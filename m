Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSLPRJI>; Mon, 16 Dec 2002 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbSLPRJI>; Mon, 16 Dec 2002 12:09:08 -0500
Received: from ulima.unil.ch ([130.223.144.143]:8120 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S266810AbSLPRJI>;
	Mon, 16 Dec 2002 12:09:08 -0500
Date: Mon, 16 Dec 2002 18:17:03 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Alex Goddard <agoddard@purdue.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
Message-ID: <20021216171703.GD13198@ulima.unil.ch>
References: <20021216094514.GA735@ulima.unil.ch> <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 11:19:00AM +0000, Alex Goddard wrote:

> > I have just patched 2.5.51, and not done the make clean && make mrproper
> > before doing a make menuconfig && make dep && make bzImage && make
> > modules...
> > 
> > Will that change anything to make clean/mrproper here?
> 
> I would give 'make clean' a try.

I am just doing that right now... I'll wait till completion to report
the issue:

No change, still the same messages :-(

Thank you very much and have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
