Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272775AbTG3GRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272776AbTG3GRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:17:53 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:384 "EHLO dust")
	by vger.kernel.org with ESMTP id S272775AbTG3GRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:17:52 -0400
Date: Wed, 30 Jul 2003 01:21:37 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Studying MTD <studying_mtd@yahoo.com>
Cc: Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.0-test1 : modules not working
In-Reply-To: <20030730054155.34832.qmail@web20503.mail.yahoo.com>
Message-ID: <Pine.LNX.4.56.0307300120200.3692@dust>
References: <20030730054155.34832.qmail@web20503.mail.yahoo.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Studying MTD wrote:

> module-init-tools-0.9.12 is giving :-
> 
> #insmod hello_module.o
> No module found in object
> Error inserting 'hello_module.o': -1 Invalid module
> format
> 
> #file hello_module.o
> hello_module.o: ELF 32-bit LSB relocatable, Hitachi
> SH, version 1 MathCoPro/FPU/MAU Required (SYSV), not
> stripped
> 
> how to fix this.

Some information on how you built hello_module.o would be nice.  You might
also want to look at the first two (at least) articles here:  
http://lwn.net/Articles/driver-porting/

-- 
Alex Goddard
agoddard@purdue.edu
