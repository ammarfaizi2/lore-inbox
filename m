Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTIDOTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbTIDOTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:19:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264984AbTIDOTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:19:32 -0400
Date: Thu, 4 Sep 2003 15:19:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       parisc-linux@lists.parisc-linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add MODULE_ALIAS_LDISC to asm-parisc/termios.h
Message-ID: <20030904141928.GO18654@parcelfarce.linux.theplanet.co.uk>
References: <20030904135315.GB2411@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904135315.GB2411@conectiva.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:53:15AM -0300, Arnaldo Carvalho de Melo wrote:
> 	This patch makes it compile, doing the same thing that was done to
> include/asm-i386/termios.h, please see if this is acceptable, if it is I can
> provide the same patch for all the other arches.

if it's the same for all arches, why not put it in <linux/termios.h>?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
