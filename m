Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSFVTuO>; Sat, 22 Jun 2002 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSFVTuN>; Sat, 22 Jun 2002 15:50:13 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1800 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316884AbSFVTuM>;
	Sat, 22 Jun 2002 15:50:12 -0400
Date: Sat, 22 Jun 2002 21:54:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2
Message-ID: <20020622215453.A13719@mars.ravnborg.org>
References: <Pine.SGI.4.30.0206202040260.8750970-100000@attila.stevens-tech.edu> <Pine.LNX.4.44.0206212042550.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206212042550.8911-100000@serv>; from zippel@linux-m68k.org on Fri, Jun 21, 2002 at 08:55:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 08:55:10PM +0200, Roman Zippel wrote:

> Anyway, not all hope is lost, I started my own configuration system some
> time ago, which will be less complex than CML2. It's only advancing a bit
> slowly currently, as I only have little time to work on it.

Hi Roman.
Despite the fact that you are advancing slowly could you explain what your plans
are with the configuration system?

As of today we have basically three different ways to read the Config.in files,
where xconfig are the one with the best but also most critical parser/analyser.
Do you plan to replace all of them or?

Have you planned to let CML1 and ZCONF(or whatever you planned to call the
new semantic) co-exist?

	Sam
