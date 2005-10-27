Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVJ0Ie4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVJ0Ie4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVJ0Ie4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:34:56 -0400
Received: from web33312.mail.mud.yahoo.com ([68.142.206.127]:25237 "HELO
	web33312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964999AbVJ0Iez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:34:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yOwL87M5lGQqeldtjEEuECMl9mIBvf0MIBsBEgowMaIZlGHAMpeMOzCwQG2fV9Z2JpUBS+jHJ1Qc97PRmmfj0lh82Mw8kefVwjSXD7McJpaWeLu8MvVcFrbxGjZy2u/iaem2R0PjtgnkLR1jelEAnvv5txubuiSXn5hURJ1qvFY=  ;
Message-ID: <20051027083453.40596.qmail@web33312.mail.mud.yahoo.com>
Date: Thu, 27 Oct 2005 01:34:52 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: loading a module during boot time
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On booting the machine with 2.6 it panics in loading
the megaraid_mbox driver.
This module is a part of the kernel.
I want the kernel to use megaraid driver instead of
megaraid_mbox.
Is there any way to do this, other than rebuilding the
kernel.

-Thanks.



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
