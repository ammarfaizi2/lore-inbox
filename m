Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSGQM5u>; Wed, 17 Jul 2002 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSGQM5t>; Wed, 17 Jul 2002 08:57:49 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37036 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313416AbSGQM5s>;
	Wed, 17 Jul 2002 08:57:48 -0400
Date: Wed, 17 Jul 2002 15:00:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717150043.A19609@ucw.cz>
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz> <3D355940.96EE8327@delusion.de> <20020717141004.C12529@ucw.cz> <3D355FD0.9F0E4F8@delusion.de> <20020717142933.B19385@ucw.cz> <3D356609.11B46A5C@delusion.de> <20020717144410.A19543@ucw.cz> <3D356901.A801A78F@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D356901.A801A78F@delusion.de>; from reality@delusion.de on Wed, Jul 17, 2002 at 02:54:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:54:25PM +0200, Udo A. Steinberg wrote:
> Vojtech Pavlik wrote:
> > 
> > Can you check with evtest again? Up should be showing as -1, down as 1.
> 
> With my patch up is 1 and down is -1 and things scroll the right way.

What protocol are you using in X?
Does this happen with both ExplorerPS/2 and ImPS/2?

> > If it doesn't, then there is another direction bug elsewhere.
> 
> Possibly.

mousedev.c

-- 
Vojtech Pavlik
SuSE Labs
