Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272763AbTG3Fm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272764AbTG3Fm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:42:58 -0400
Received: from web20503.mail.yahoo.com ([216.136.226.138]:47944 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272763AbTG3Fm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:42:57 -0400
Message-ID: <20030730054155.34832.qmail@web20503.mail.yahoo.com>
Date: Tue, 29 Jul 2003 22:41:55 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: linux-2.6.0-test1 : modules not working
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730045157.GA5655@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module-init-tools-0.9.12 is giving :-

#insmod hello_module.o
No module found in object
Error inserting 'hello_module.o': -1 Invalid module
format

#file hello_module.o
hello_module.o: ELF 32-bit LSB relocatable, Hitachi
SH, version 1 MathCoPro/FPU/MAU Required (SYSV), not
stripped

how to fix this.

Thanks.

--- Joshua Kwan <joshk@triplehelix.org> wrote:
> On Tue, Jul 29, 2003 at 09:37:17PM -0700, Studying
> MTD wrote:
> > modprobe: QM_MODULES: Function not implemented
> > modprobe: QM_MODULES: Function not implemented
> 
> Next time, please STFW, RTFM (in this case,
> post-halloween-2.5.txt on
> lwn.net), and you would already know that you need
> module-init-tools,
> available at rusty's page on kernel.org.
> 
> -Josh
> 
> -- 
> Using words to describe magic is like using a
> screwdriver to cut roast beef.
> 		-- Tom Robbins
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
