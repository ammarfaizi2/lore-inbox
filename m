Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290738AbSAYRTz>; Fri, 25 Jan 2002 12:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290740AbSAYRTs>; Fri, 25 Jan 2002 12:19:48 -0500
Received: from ns.suse.de ([213.95.15.193]:8717 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290738AbSAYRTd>;
	Fri, 25 Jan 2002 12:19:33 -0500
Date: Fri, 25 Jan 2002 18:19:31 +0100
From: Dave Jones <davej@suse.de>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Message-ID: <20020125181931.G28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1011972717.22707.42.camel@psuedomode> <Pine.GSO.4.21.0201251802491.19355-100000@skiathos.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201251802491.19355-100000@skiathos.physics.auth.gr>; from kostas@skiathos.physics.auth.gr on Fri, Jan 25, 2002 at 06:10:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 06:10:35PM +0200, Liakakis Kostas wrote:

 > I guess this is the PowerNOW! feature of the mobile Athlons/Durons with
 > the Palomino core. I think this is totaly different than STPGNT. And this
 > would be worth implementing if it can be supported on desktop Athlon/Duron
 > models/mobos.
 > 
 > Anybody has more info about this?

 I checked in powernow-k7.c to the cpufreq CVS today.
 So far it doesn't do anything other than detect the ability
 to scale voltage/speed. I'll add that later.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
