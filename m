Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUL3E3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUL3E3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUL3E3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:29:09 -0500
Received: from web60607.mail.yahoo.com ([216.109.118.245]:42641 "HELO
	web60607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261513AbUL3E3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:29:05 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=D6a8qmOBEdHJjsFlrCzLCxz52g4qlBIXxeXPiK9tv5exfJ9PWECT22ksNXinMevC7UGMdsSQ65xaJdqHlDkRV0cOAqtR8E4lrq+dgL1GqhFzSj4P6WuymAd8GZj9fOGesSKWp6hGKtATyfYE7/CY5zpNqqNAiGyCjctp3DzfqDw=  ;
Message-ID: <20041230042905.44219.qmail@web60607.mail.yahoo.com>
Date: Wed, 29 Dec 2004 20:29:05 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Unable to find syscall number for some system calls
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I am intercepting system calls in 2.4.28 kernel
for my project work. While I was looking for syscall
numbers for system calls related to semaphores like
semop,semget..the appropriate numbers were  missing in
the asm/unistd.h file. For other system calls like
sys_pipe numbers are present in the above file. What
should I do to intercept these system calls? Where
should I look for the related syscall numbers?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 
