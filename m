Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWGLJJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGLJJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWGLJJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:09:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6048 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751002AbWGLJJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:09:47 -0400
Date: Wed, 12 Jul 2006 11:09:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Fredrik Roubert <roubert@df.lth.se>
cc: Andrew Morton <akpm@osdl.org>, pavel@ucw.cz, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <20060712072628.GB5869@igloo.df.lth.se>
Message-ID: <Pine.LNX.4.64.0607121108050.12900@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
 <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home>
 <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home>
 <20060711224225.GC1732@elf.ucw.cz> <Pine.LNX.4.64.0607120132440.12900@scrub.home>
 <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home>
 <20060712072628.GB5869@igloo.df.lth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Jul 2006, Fredrik Roubert wrote:

> The work-around suggested in the documentation ([Y]ou might have better
> luck with "press Alt", "press SysRq", "release Alt", "press <command
> key>", release everything.) does not work with keyboards that sends the
> make and break codes for SysRq immediately after another, and this was
> the reason for changing the behaviour (for broken keyboards) in
> 2.6.18-rc1. The new behaviour works with every keyboard the people
> involved in this discussion has heard of.

Could you please try to get both methods working?

bye, Roman
