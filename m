Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUJ2So0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUJ2So0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUJ2So0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:44:26 -0400
Received: from holomorphy.com ([207.189.100.168]:45203 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263382AbUJ2S1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:27:47 -0400
Date: Fri, 29 Oct 2004 11:27:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Help re Frame Buffer/Console Problems
Message-ID: <20041029182728.GE12934@holomorphy.com>
References: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:22:11PM +0100, Mark Fortescue wrote:
> I have been trying to get a CG3 sparc clone up and running with linux.
> Under 2.2.26, the console is fine. During the development of the
> 2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
> to track done one of the problems (the blanking code had some typing
> errors in it) and this gave me a logo + black screen and cursor using a
> linux-2.2.8.1 kernel. Still no console text.
> Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
> appropriate patches and made some additional mods to keep the
> compiler/linker happy. Now I have a black console, no text, logo or cursor
> and if I redirect the console output to a serial port I get the following:

Okay, sounds like a relatively major disaster. =(


-- wli
