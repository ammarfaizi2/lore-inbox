Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUAEIgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAEIge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:36:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:48014 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265899AbUAEIgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:36:33 -0500
Date: Mon, 5 Jan 2004 09:36:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: New set of input patches
Message-ID: <20040105083619.GA16580@ucw.cz>
References: <200401030350.43437.dtor_core@ameritech.net> <200401050059.25031.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401050059.25031.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:59:24AM -0500, Dmitry Torokhov wrote:

> I made 3 more input patches:
> 
> - compile fix in 98busmose driver (it still had its interrupt routine
>   returning voooid instead of irqreturn_t)
> - the rest of mouse devices converted to the new way of handling kernel
>   parameters and document them in kernel-parametes.txt
> - convert tsdev module to the new way of handling kernel parameters and
>   document them in kernle-parameters.txt.
> 
> The patches can be found at the following addresses:
> http://www.geocities.com/dt_or/input/2_6_1-rc1/
> http://www.geocities.com/dt_or/input/2_6_1-rc1-mm1/
> 
> Vojtech, Andrew,
> 
> are you interested in these kind of patches and should I take a stab at
> converting joysticks diectory as well?

Yup, I am. :) Not sure if it's 2.6.[12] stuff, but it needs to be done
sooner or later.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
