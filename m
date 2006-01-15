Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWAOMbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWAOMbo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWAOMbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:31:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35592 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751908AbWAOMbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:31:44 -0500
Date: Sun, 15 Jan 2006 13:31:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Message-ID: <20060115123133.GB15881@mars.ravnborg.org>
References: <200601151051.14827.rene@exactcode.de> <200601151141.30876.rene@exactcode.de> <20060115111922.GA13673@mars.ravnborg.org> <200601151312.42391.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601151312.42391.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm curious, aside rsbac, what in the .config is altering the KERNELRELEASE?
CONFIG_LOCALVERSION
CONFIG_LOCALVERSION_AUTO

	Sam
