Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUBHOVo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 09:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBHOVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 09:21:44 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30437 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263625AbUBHOVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 09:21:43 -0500
Date: Sun, 8 Feb 2004 15:21:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert F Merrill <griever@t2n.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 seems to break ALSA and DRI module compilation
Message-ID: <20040208142137.GR7388@fs.tum.de>
References: <40258EE2.9000507@t2n.org> <4025B734.8080102@t2n.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025B734.8080102@t2n.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 11:12:36PM -0500, Robert F Merrill wrote:
> Robert F Merrill wrote:
> 
> >Just got 2.6.2-mm1 running... however I get a bunch of module errors
> >when I try to load my (seperately compiled) ALSA and DRI modules
> >
> >first of all, nearly every alsa module complains about a billion 
> >undefined symbols
> >secondly, I get the error "module falsely claims to have symbol ^A".
> >
> >
> *snip*
> 
> >I'm going to go to vanilla 2.6.2 and see if that has the problem.
> >
> It doesn't, seems to be a -mm1 specific bug.

Please send your .config .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

