Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbULXEp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbULXEp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 23:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbULXEp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 23:45:58 -0500
Received: from web60607.mail.yahoo.com ([216.109.118.245]:2444 "HELO
	web60607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261373AbULXEpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 23:45:54 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=DHEaSD+IxIJ5mIaM8af7VSC4jxONbobc6pUpiox1QDQbvKDTd8AxPQMTEknktrD859fEq0aWi9WFNclXL5ENSL0bSsIe+rV/HVh65C4VB287Mcs5RN17NJNn+u0kbjUOd0l2iCUtQ85zapt8ChJDVDLsJljjBAw52oFotZddAZY=  ;
Message-ID: <20041224044553.84241.qmail@web60607.mail.yahoo.com>
Date: Thu, 23 Dec 2004 20:45:53 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Intercepting system calls in Linux kernel 2.6.x
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
 In linux kernel 2.6.x, what should we do to intercept
system calls? When I used sys_call_table from a
module, it returned the following error 'undefined
variable sys_call_table'. What is the way to export
system call table in kernel 2.6.x?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
