Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUK1W5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUK1W5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUK1W5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:57:44 -0500
Received: from web51909.mail.yahoo.com ([206.190.39.52]:3416 "HELO
	web51909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261513AbUK1W51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:57:27 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Q1qS802JeRHqJNXc3cOGs5DthmSPyUKaw2AALQpeA2s0ib2irM1Z/BKgOBWBUxCYDX/ArQ91U0FXN2ujahXYtRXlfcqmUeV3fn0KJsVHeUbwVAiRgqEju0q2ZE6DFpti+nRcAGOt+CDKWMYm8S/cmORmqBs9oDIQ0PClN7QbFj0=  ;
Message-ID: <20041128225720.99389.qmail@web51909.mail.yahoo.com>
Date: Sun, 28 Nov 2004 14:57:20 -0800 (PST)
From: A M <alim1993@yahoo.com>
Subject: Accessing a process structure in the processes link list
To: linux-kernel@vger.kernel.org, linux-assembly@vger.kernel.org,
       linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible for a program running as root
that wasn't compiled with the kernel to access a
process structure in the processes link list? 

I've read an article about hiding processes and the
article made sound so easy to access the link list and
hide a process, how easy is it? 

Is it possible to a process to access its own entry in
the processes link list?


Thanks, 

Ali 




		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

