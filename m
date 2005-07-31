Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVGaVyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGaVyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVGaVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:54:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7313 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261947AbVGaVyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:54:15 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050731211020.GB27433@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122678943.9381.44.camel@mindpipe>
	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu>  <20050731211020.GB27433@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 17:54:13 -0400
Message-Id: <1122846853.13000.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 23:10 +0200, Pavel Machek wrote:
> > I really like having 250HZ as an _option_, but what I don't see is why 
> > it should be the _default_.  I believe this is Lee's position as
> > Last I checked, ACPI and CPU speed scaling were not enabled by default; 
> 
> Kernel defaults are irelevant; distros change them anyway.

OK, so HZ should be left at 1000 so "make oldconfig" continues to do the
right thing.  It is supposed to give me my old config, right?

Lee

