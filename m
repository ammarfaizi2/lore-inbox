Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266531AbSKGKvO>; Thu, 7 Nov 2002 05:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266532AbSKGKvO>; Thu, 7 Nov 2002 05:51:14 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:36613 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266531AbSKGKvN>; Thu, 7 Nov 2002 05:51:13 -0500
Date: Thu, 7 Nov 2002 11:57:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: kbuild-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory
 .so
In-Reply-To: <20021107100021.GL4182@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0211071149200.13258-100000@serv>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org>
 <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Nov 2002, Peter Samuelson wrote:

> Basically, what I'm saying is, I see no need for the existing .so in
> the kernel build, much less another one.  Static libraries are ever so
> much easier to manage.

If you want to limit people to the config tools in the kernel, there is 
indeed no need for a shared library. Note that during the next development 
cycle all graphical front ends are possibly removed.

bye, Roman

