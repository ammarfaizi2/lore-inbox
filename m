Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbSAARtD>; Tue, 1 Jan 2002 12:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbSAARsx>; Tue, 1 Jan 2002 12:48:53 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:44805 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S282508AbSAARsp>;
	Tue, 1 Jan 2002 12:48:45 -0500
Date: Fri, 28 Dec 2001 00:27:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011228002734.B4265@elf.ucw.cz>
In-Reply-To: <20011226233413.GA17037@msp-150.man.olsztyn.pl> <Pine.LNX.4.21.0112262355110.3044-100000@Consulate.UFP.CX> <20011227005236.GB17344@msp-150.man.olsztyn.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227005236.GB17344@msp-150.man.olsztyn.pl>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Nice, but - as Eric pointed out - there are many options where the
> "available as module" text actually contains a module name, which
> causes problems and makes your proposition insufficient for our needs.
> A complete solution would require serious changes which Eric doesn't
> want to introduce into a stable version.

That "module" help text deserves to *die*. Explanation of modules
should be provided *once* in CONFIG_MODULES.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
