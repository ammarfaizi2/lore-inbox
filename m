Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTA2H6T>; Wed, 29 Jan 2003 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTA2H6T>; Wed, 29 Jan 2003 02:58:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:58128
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265205AbTA2H6S>; Wed, 29 Jan 2003 02:58:18 -0500
Date: Wed, 29 Jan 2003 03:06:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Stefan Reinauer <stepan@suse.de>, Robert Morris <rob@r-morris.co.uk>,
       Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
In-Reply-To: <200301281452.02856.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0301290306090.4761-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003, Roy Sigurd Karlsbakk wrote:

> On Tuesday 28 January 2003 14:32, Stefan Reinauer wrote:
> > * Robert Morris <rob@r-morris.co.uk> [030128 12:20]:
> > > There is a very simple reason why Linux shouldn't have a "bootscreen" -
> > > its a lame idea. We have copied enough of the bad "features" of Windows
> > > et al into Linux already, IMHO.
> 
> I'm working for a company doing VoD and IPTV applications, and you surely 
> don't want some verbose kernel output upon booting set-top-boxes. At least - 
> the customer doesn't want it, meaning you shouldn't have it. Then it's better 
> to have some LED flashing in case of error.

Then don't output kernel messages to your default display device. No 
Kernel Hacking Required (tm)

	Zwane
-- 
function.linuxpower.ca

