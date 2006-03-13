Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWCMLE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWCMLE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWCMLE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:04:27 -0500
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:55405 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750860AbWCMLE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:04:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AvWONfxnSHuu5qky3N5kPn/lEO9qDz6sRVNi3RxoBQpIhZevnzcN9DqfN0VyuEeKEmOPeDbpxsFpl4qyn9X+f7os9Gt45PwGJN4wHRaSKoXQ1Vb9IWx3sD88vfnE1ZyEbT1660M4HSWvOK8K0fJbdSsSL97wK95rb7HW7qfRvmA=  ;
Message-ID: <20060313110423.51666.qmail@web33315.mail.mud.yahoo.com>
Date: Mon, 13 Mar 2006 03:04:23 -0800 (PST)
From: li nux <lnxluv@yahoo.com>
Subject: dm: Unable to get INQUIRY vpd 1 page 0x0
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On doing a '/etc/init.d/boot.udev start' or 'multipath
-v2 -d' i get following error for all the devices:

0:0:0:1: sg_io failed status 0x0 0x1 0x0 0x0
0:0:0:1: Unable to get INQUIRY vpd 1 page 0x0.
error calling out /sbin/scsi_id -g -u -s /block/sda

I have qlogic devices.
Can somebody have an idea, what i need to correct.

-lnxluv

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
