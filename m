Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUL2MUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUL2MUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUL2MUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:20:21 -0500
Received: from web60604.mail.yahoo.com ([216.109.118.242]:5507 "HELO
	web60604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261179AbUL2MUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:20:14 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=emEUb+Qlym/aYb+7JCh5BD7gC2YfrX4Rw/q+Gwuc/atePDWmKQzA6zZDji1YLkrl8qTN8eRFsQONMf7/1VddbmvAs/XP5/eLU1q/VnxJYJ5VSKUrdi4RH2NVx//Sf1EZEFQb4PTPYlmf8QCToN1+LRdCeiZ/yZn4tBBJtFOWZws=  ;
Message-ID: <20041229122014.59712.qmail@web60604.mail.yahoo.com>
Date: Wed, 29 Dec 2004 04:20:14 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Adding new process state
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I want to add a new process state in Linux kernel
for my project work. In the main scheduler source file
I found the process states numbered in the order of 2
like 1,2,4...32. should I use 64 for my new process
state or can I use any number?
 plz help me.

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
