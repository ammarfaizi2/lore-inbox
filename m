Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293213AbSBWVa7>; Sat, 23 Feb 2002 16:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293216AbSBWVav>; Sat, 23 Feb 2002 16:30:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46321
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293213AbSBWVaj>; Sat, 23 Feb 2002 16:30:39 -0500
Date: Sat, 23 Feb 2002 13:30:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20269 support?
Message-ID: <20020223213049.GM20060@matchmail.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16ejba-00068Z-00@the-village.bc.nu> <Pine.LNX.4.30.0202232223590.13846-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202232223590.13846-100000@mustard.heime.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 10:25:37PM +0100, Roy Sigurd Karlsbakk wrote:
> > > Does anyone know when (or if) the PDC20269 driver will be merged into the
> > > official 2.4 kernel?
> >
> > With luck 2.4.19
> >
> 
> What's the problem with it? I've been using the current one for a couple
> of months without any problems, and I have tested it with a
> half-a-terabyte RAID-0 with really high load. It's never let me down...
> 
> roy

IIRC there was much controvercy about the ide patches when 2.4.18-pre-early
was open, and when the things washed over that time window was closed.
Marcello only accepts large changes in 2.4-pre-early, so it was too late...

Mike
