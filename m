Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312927AbSDOQTk>; Mon, 15 Apr 2002 12:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSDOQTj>; Mon, 15 Apr 2002 12:19:39 -0400
Received: from ns.suse.de ([213.95.15.193]:62224 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312927AbSDOQTi>;
	Mon, 15 Apr 2002 12:19:38 -0400
Date: Mon, 15 Apr 2002 18:19:34 +0200
From: Dave Jones <davej@suse.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>,
        linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.5.8
Message-ID: <20020415181934.K32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020415161601.31430a76.Corporal_Pisang@Counter-Strike.com.my> <Pine.LNX.4.44.0204151054240.13828-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >   Avoid a compile-time warning in bluesmoke.c
 >   (intel_thermal_interrupt() defined but not used)

I already sent Linus an update for this (and a few other bits),
fixing it in a different way. (CONFIG_MPENTIUM4), although it
should probably be a CONFIG_P4_THERMAL or the likes.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
