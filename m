Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbUKWRsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUKWRsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUKWRsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:48:00 -0500
Received: from web52503.mail.yahoo.com ([206.190.39.124]:29268 "HELO
	web52503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261393AbUKWR0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:26:32 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Iq3fZrRDzu1/cst1GFNb1PX/vw9w9o4Y1cmGEQy+Revmang8CasdnA4I01GzvakupCJQCSYlBR8+W6o0SlXNrOHk5DLNiqznwvIWZsc0ITSR9wjvgzXPG/J8R2LnAmpVDoH/hw7S8RDvMQ3DRwKJN+6IkcKNlPste2UaWCeepBw=  ;
Message-ID: <20041123172627.57807.qmail@web52503.mail.yahoo.com>
Date: Tue, 23 Nov 2004 09:26:27 -0800 (PST)
From: johon Doe <johond@yahoo.com>
Subject: problems with ich6r
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I found maybe a bug over ich6r sata controller.
here,
http://groups.google.it/groups?q=johond&hl=it&lr=&ie=UTF-8&selm=33pIh-8l5-51%40gated-at.bofh.it&rnum=2
you can find a kind of debian sarge installation
bugreport.
I found the same bug with different livecd: gentoo and
knoppix. Simply since few seconds I write over the
disk the system crash or it give me those errors u can
find to the google/groups link.
I also tryed with the latest 2.6.10rc2 kernel with the
same errors.
The following is my hardware:

cpu: pentium4 3000Mhz
ram: 1G
mobo: asus p5gd1 with 915p (northbridge) and ich6r
(southbridge).
hd: 2 Maxtor maxline3 300GB

The hard disks ara attached to the intel chipset sata
controller (ich6r).
I tryed the same hard disk over a amd64 machine (mobo
asus k8n-e) with nForce3 controller and I havent had
any problems.


At the google link u can find the lspci and lspci -n
output.
Thx very much for any kind of help.

 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
