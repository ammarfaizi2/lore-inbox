Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULUEW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULUEW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 23:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbULUEW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 23:22:28 -0500
Received: from web60608.mail.yahoo.com ([216.109.119.82]:26967 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261430AbULUEWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 23:22:25 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=mJgIqzqggT7IIWEq6VVc3EOj5mEx6wTLvMzgBiCnf/LwbbyOi1/DmGGciOsknryzPGJNd4ZDpiXo4CalmESU2GY8qKVdiQGQnmdcTauDLeU0LKU1bjsff2eVt/WQJji/dXUnUxF8UpfQ5TW6lOvJ8BfUToPk2ViXPC06rBXCU7o=  ;
Message-ID: <20041221042224.48160.qmail@web60608.mail.yahoo.com>
Date: Mon, 20 Dec 2004 20:22:24 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Intercepting system calls
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I want to intercept system calls that are provided
for IPC in Linux. I have to determine whether a
process blocks while executing a system call and I
must save the arguments passed to that system call.
    Can I modify the system call source code directly
for this? or if I want the system calls to refer my
module, how should I do that? can anyone explain for
this, if possible with some code?..

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

