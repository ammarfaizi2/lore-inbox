Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVG0LOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVG0LOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVG0LOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:14:42 -0400
Received: from web8410.mail.in.yahoo.com ([202.43.219.158]:43924 "HELO
	web8410.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262192AbVG0LMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:12:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ieEwDdjTZhMzZa1XQBCLt/gItt+KMoGGNCrXZWSlzP1qKUewdro45hgC/wqSUuPUvzWFnXtt/hLL/cvWw7rkCRR60PBOmFzg+eIAITGQqXF3Tz1hi63eUtr6vpm2qmsdvVUmMG1x934Xz8wb52HZGMwP+ddY4zzRQFt4fPH3vBQ=  ;
Message-ID: <20050727111225.3662.qmail@web8410.mail.in.yahoo.com>
Date: Wed, 27 Jul 2005 12:12:25 +0100 (BST)
From: Rahul Tank <rahul5311@yahoo.co.in>
Subject: serial device driver
To: Linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,
   i am writing a serial device driver. After going
thru few linux journals i have understood that serial
ports get mapped at standard addrerss.We need to take
these regions, register driver and talk to them
(read,write).
 
  however i am unable to do the same.
 plz help me


		
__________________________________________________________
How much free photo storage do you get? Store your friends 'n family snaps for FREE with Yahoo! Photos http://in.photos.yahoo.com
