Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319265AbSHWTu2>; Fri, 23 Aug 2002 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319260AbSHWTtq>; Fri, 23 Aug 2002 15:49:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24704 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319261AbSHWTtU>;
	Fri, 23 Aug 2002 15:49:20 -0400
Date: Fri, 2 Nov 2001 01:25:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, Andrew Rodland <arodland@noln.com>,
       Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Message-ID: <20011102012515.A35@toy.ucw.cz>
References: <3D5A8C2C.9010700@yahoo.com> <20020814184407.4ca9e406.arodland@noln.com> <200208150821.g7F8L6p19730@Port.imtp.ilyichevsk.odessa.ua> <E17fI5E-0002at-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E17fI5E-0002at-00@starship>; from phillips@arcor.de on Thu, Aug 15, 2002 at 12:42:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In short: making it work right on wide variety of hardware is next to impossible
> > and even then results are mediocre (low volume, radio quality).
> 
> So what?  If it works on *your* hardware then you want the option.

It will work well enough to be used for speech synthesis on most hw. It only
eats CPU when in use. [Integrating festival into kernel for *speaking* panics?]


									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

