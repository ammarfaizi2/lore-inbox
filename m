Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVCWRiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVCWRiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVCWRiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:38:50 -0500
Received: from imo-m19.mx.aol.com ([64.12.137.11]:14324 "EHLO
	imo-m19.mx.aol.com") by vger.kernel.org with ESMTP id S261966AbVCWRi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:38:28 -0500
From: AndyLiebman@aol.com
Message-ID: <1c8.2527d2ae.2f73038b@aol.com>
Date: Wed, 23 Mar 2005 12:38:19 EST
Subject: Module compiling issue
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this isn't the best place to ask this  question -- it's kind of a 
newbie question -- but I'm very frustrated.  

Ever since I started using the 2.6.9 kernel and above, I have had  frequent 
troubles compiling drivers AFTER the new kernel is installed and booted  up. 

In other words, no issue compiling the kernel itself, as well as all  the 
modules. But then, if I try to compile a module later (i.e., 3ware 9xxx  driver 
or Chelsio 10 Gigabit NIC driver), when I type: 

"make" or "make  -f Makefile" I get back an error: 

"No rule to make target 'for' "   or "No rule to make target 'driver' ".  
Have I missed configuring something  in the kernel. I have gotten this to work 
once with the 2.6.10 kernel, but I  don't know what I did differently then. 

I would appreciate your help  here. 

Andy Liebman  

