Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSLOApH>; Sat, 14 Dec 2002 19:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLOApH>; Sat, 14 Dec 2002 19:45:07 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:35122
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266108AbSLOApH>; Sat, 14 Dec 2002 19:45:07 -0500
Date: Sat, 14 Dec 2002 19:55:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Matthew Bell <mwsb@operamail.com>, "" <linux-parport@torque.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Obvious(ish): 3c515 should work if ISAPNP is a module.
In-Reply-To: <Pine.LNX.4.50.0212141944400.32566-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0212141954470.32566-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0212141709250.7099-100000@chaos.physics.uiowa.edu>
 <Pine.LNX.4.50.0212141944400.32566-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Zwane Mwaikambo wrote:

> > +#ifdef __ISAPNP__
> >
> > which will get all cases right.
>
> ... but unfortunately thats currently going away ;) to make way for
> CONFIG_PNP
>
> 	Zwane
>

Someone needs their coffee...

-- 
function.linuxpower.ca
