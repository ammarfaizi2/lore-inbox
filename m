Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUAPVJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbUAPVJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:09:34 -0500
Received: from web12008.mail.yahoo.com ([216.136.172.216]:27960 "HELO
	web12008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265826AbUAPVJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:09:29 -0500
Message-ID: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
Date: Fri, 16 Jan 2004 13:09:24 -0800 (PST)
From: Ashish sddf <buff_boulder@yahoo.com>
Subject: Compiling C++ kernel module + Makefile
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
   I am trying to port a C++ kernel module from 2.4 to
2.6. (It is MIT Click Modular Router). 

   As I understand the module building has changed in
ver 2.6. I have got the Makefile to compile it but it
gives me lot of warning - all dependancies problem 

 It appears that the kernel Makefile treats it like a
host application and does not pass the necessary
processing routines.


  Does anyone can ideas about how to change the kernel
makefile to compile the C++ files the same way as C
files ? 


Any help will be appreciated. 


Ashish 


__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
