Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUL3ExA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUL3ExA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbUL3ExA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:53:00 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:42623 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261535AbUL3Ewk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:52:40 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=O+gdY2E/rhEYrqI6TXiH48gBfy0BsycH3fEKKfGtfUoNqsm7e5rWX76y4F/Oj3YXs5xuWga95FNypMFVQRL8ILc7CPGFngzghAriqIxpJ9Nb06Z0I5ctm/dBUb2vzlGVL3lCNsAXnFHRcs/hxCgyOEedn4i8ZXDUR6kmltJzeCM=  ;
Message-ID: <20041230045236.19022.qmail@web60606.mail.yahoo.com>
Date: Wed, 29 Dec 2004 20:52:36 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Finding whether a process blocked while executing a syscall
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I am intercepting system calls in linux kernel
2.4.28 for my project work. 
    A process can be blocked while executing a syscall
in the light of some resources needed. Now, I want to
find out whether a process has been blocked while
executing a particular syscall or it has finished it
successfully? If it was blocked I want to perform some
operation on it. Can anyone help me regarding this?

Thanks,
selva

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
