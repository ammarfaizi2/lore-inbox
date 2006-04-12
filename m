Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWDLJkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWDLJkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWDLJkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:40:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56002 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932124AbWDLJkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:40:19 -0400
Date: Wed, 12 Apr 2006 11:40:18 +0200
From: Martin Mares <mj@ucw.cz>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Pramod Srinivasan <pramods@gmail.com>, David Weinehall <tao@acc.umu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <mj+md-20060412.093650.16425.atrey@ucw.cz>
References: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com> <Pine.LNX.4.61.0604121057360.12544@yvahk01.tjqt.qr> <443CC6CE.6070102@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443CC6CE.6070102@stesmi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That's almost forcing the person who wrote the kernel part to write
> a GPL'd program JUST because there is a proprietary program using
> his stuff - and THAT is insane.

If the kernel part does something, which can work _separately_, i.e.,
do something useful without the proprietary program, then it's very
likely OK. Otherwise, the proprietery program cannot be considered
a work separate from the kernel part.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If Bill Gates had a nickel for every time Windows crashed... ..oh wait, he does.
