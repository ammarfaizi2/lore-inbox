Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbTCPReW>; Sun, 16 Mar 2003 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262704AbTCPReW>; Sun, 16 Mar 2003 12:34:22 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:19728 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262703AbTCPReW>; Sun, 16 Mar 2003 12:34:22 -0500
Date: Sun, 16 Mar 2003 18:45:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andrea Arcangeli <andrea@suse.de>
cc: Ben Collins <bcollins@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030316034821.GS1252@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303161813490.12110-100000@serv>
References: <20030312174244.GC13792@work.bitmover.com> <20030312183413.GH563@phunnypharm.org>
 <20030316034821.GS1252@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Mar 2003, Andrea Arcangeli wrote:

> true but the missing bits are nearly worthless, I wouldn't be ok with
> CVS if this wasn't the case. I mean, in the very worst case, we're not
> totally screwed, we probably won't even notice the difference.

The missing bits are absolutely not worthless. They are very useful when 
you want to test other SCM system to simulate distributed development.

bye, Roman

