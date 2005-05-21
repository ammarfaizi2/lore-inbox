Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVEUXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVEUXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 19:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEUXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 19:24:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261678AbVEUXYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 19:24:52 -0400
Date: Sun, 22 May 2005 01:24:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>
Cc: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050521232451.GK4489@stusta.de>
References: <200505201345.15584.pmcfarland@downeast.net> <428E70B3.1050007@khandalf.com> <20050521073826.GR5112@stusta.de> <1116674703.5301.14.camel@gimli.at.home> <428F1E71.6010000@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428F1E71.6010000@tomt.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 01:41:37PM +0200, André Tomt wrote:
> Bernd Petrovitsch wrote:
> >Did you ever see Solaris installations without GNU-tools from
> >sunfreeware.com installed?
> 
> Hnngh! Missing dependencies (do the package format support it at all?), 

Solaris packages support dependencies.
That's what the "depend" file is for.

> no splitting (why should I need apache2 for the portability library 
> libapr?), odd things like needing sunfreeware gzip instead of the 
> solaris one in some packages (something that you don't notice until its 
> too late)... its like going way back in time to slackware.

Brian complained about the package format and not about specific 
packages.

I've also seen horrible rpm or dpkg packages, but that's irrelevant when 
talking about package formats.

> </rant>
> Cheers,
> André Tomt
> With his rookie Solaris admin hat on.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

