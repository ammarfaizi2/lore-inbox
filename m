Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263331AbTC0RPt>; Thu, 27 Mar 2003 12:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RPD>; Thu, 27 Mar 2003 12:15:03 -0500
Received: from tapu.f00f.org ([202.49.232.129]:6108 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S263325AbTC0ROq>;
	Thu, 27 Mar 2003 12:14:46 -0500
Date: Thu, 27 Mar 2003 09:25:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Dominik Kubla <dominik@kubla.de>
Cc: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030327172559.GA26700@f00f.org>
References: <20030324212813.GA6310@osiris.silug.org> <20030327160220.GA29195@work.bitmover.com> <20030327170039.GA26452@f00f.org> <200303271819.41971.dominik@kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303271819.41971.dominik@kubla.de>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:19:41PM +0100, Dominik Kubla wrote:

> Well the internal busses and buffers of modern CPU's and in many
> cases also the on-die caches have ECC logic.

his email said "DIMMs"

> And if i should hazard a guess: "Restart IP valid" => Restarted
> Instruction Pre-Fetch resulted in a valid state of the pre-fetch
> queue.

could be ... i've not checked the AMD docs

> In Larry's case i'd remove the cpu cooler, clean everything and
> reassemble, since i would assume that there is a hot-spot on the
> die.

or simply remove the side of the case or increase air-conditioning and
see if that goes away or becomes less apparent, IME if you get these
sporadically rather than often it's 'just' overheating...


  --cw

