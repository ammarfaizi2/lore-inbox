Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSFYGeS>; Tue, 25 Jun 2002 02:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFYGeR>; Tue, 25 Jun 2002 02:34:17 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:22028 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315445AbSFYGeQ>; Tue, 25 Jun 2002 02:34:16 -0400
Date: Tue, 18 Jun 2002 12:55:54 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initcall depends
Message-ID: <20020618125554.Q22429@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0206171658470.22308-100000@chaos.physics.uiowa.edu> <E17K6gI-0001Ga-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E17K6gI-0001Ga-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Tue, Jun 18, 2002 at 10:17:10AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 10:17:10AM +1000, Rusty Russell wrote:
> > Then again, there's also the possibility of completing initramsfs, making
> > it mandatory, compiling things always as modules and leaving it to
> > "depmod" in initramfs to do the right thing.
> 
> If that ever happens... 8)

Until there is now way to remove init sections from modules, that
approach is pretty pointless anyway and will hopefully not
adapted to be mandatory.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
