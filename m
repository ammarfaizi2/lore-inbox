Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTD3QjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTD3QjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:39:11 -0400
Received: from mailer.syr.edu ([128.230.18.29]:11697 "EHLO mailer.syr.edu")
	by vger.kernel.org with ESMTP id S261807AbTD3QjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:39:08 -0400
X-WebMail-UserID: mamiling
Date: Wed, 30 Apr 2003 12:51:28 -0400
From: "Matthew A. Miling" <mamiling@mailbox.syr.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00105840
Subject: Measuring CPU with Hyperthreading and Linux
Message-ID: <3EB61ACD@OrangeMail>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: InterChange (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Please personally CC my email address to any responses:
  mamiling@syr.edu

I am currently running a dual Pentium 4 Xeon 2.4 GHz system containing Red Hat 
Linux 6.2 with the 2.4.20 kernel.  The Pentium 4 Xeons report 4 cpu's to 
/proc/cpuinfo because they are hyperthreaded.

My problem lies in trying to measure the CPU usage with such programs as top 
or gtop.  Typically, I see CPU loads in excess of 100% when I run top with 
some of my signal processing applications, but not more than 200%.  Is this 
value out of 100%, 200%, or 400%?  How does this dual, HT system kernel report 
this info to the OS?

Any help would be appreciated.  Thanks

Matt

-------------------------------------------

 Matthew A. Miling
 Graduate Student - Computer Engineering
 Syracuse University

 phone:  (315) 456-1215
 cell:   (315) 380-9307
 e-mail: mamiling@syr.edu
         matt@miling.com

-------------------------------------------

