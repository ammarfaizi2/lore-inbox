Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270915AbTGPPdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270919AbTGPPdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:33:32 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:12046 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id S270915AbTGPPdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:33:31 -0400
Message-Id: <200307161548.h6GFmNHt004144@sirius.nix.badanka.com>
Date: Wed, 16 Jul 2003 17:48:22 +0200
From: Henrik Persson <nix@syndicalist.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VESA Framebuffer dead in 2.6.0-test1
In-Reply-To: <200307161608.34637.m.watts@eris.qinetiq.com>
References: <200307161406.h6GE6iHt002041@sirius.nix.badanka.com>
	<200307161608.34637.m.watts@eris.qinetiq.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 16:08:34 +0100
Mark Watts <m.watts@eris.qinetiq.com> wrote:

*snip* 
> vesafb: framebuffer at 0xe0000000, mapped to 0xd8800000, size 16384k
> vesafb: mode is 1400x1050x24, linelength=4200, pages=2
> vesafb: protected mode interface info at c000:5378
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
> fb0: VESA VGA frame buffer device
> Console: switching to colour frame buffer device 175x65
*snip*

This is mine:
 
vesafb: framebuffer at 0x90000000, mapped to 0xcf807000, size 15296k
vesafb: mode is 1024x768x16, linelength=2048, pages=8
vesafb: protected mode interface info at c000:7926
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device

and I don't have the Console: switching to color frame buffer ...thing.

Hrm..

-- 
Henrik Persson  nix@syndicalist.net  http://nix.badanka.com
