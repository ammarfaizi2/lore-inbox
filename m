Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSKZUDM>; Tue, 26 Nov 2002 15:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbSKZUCy>; Tue, 26 Nov 2002 15:02:54 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18436 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266792AbSKZUBM>;
	Tue, 26 Nov 2002 15:01:12 -0500
Date: Tue, 26 Nov 2002 19:19:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANN: syscalltrack 0.80 "Tanned Otter" released
Message-ID: <20021126181947.GB1376@zaurus>
References: <20021123201015.GD6536@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021123201015.GD6536@alhambra>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> criteria. syscalltrack can operate either in "tweezers mode", where
> only very specific operations are tracked, such as "only track and log
> attempts to delete /etc/passwd", or in strace(1) compatible mode,
> where all of the supported system calls are traced. syscalltrack can
> do things that are impossible to do with the ptrace mechanism, because
> its core operates in kernel space. 

What stuff can you do that ptrace can't?

As UML and subterfugue.sf.net shows there's
a *lot* you can do with ptrace.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

