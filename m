Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSA3H4D>; Wed, 30 Jan 2002 02:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSA3Hzq>; Wed, 30 Jan 2002 02:55:46 -0500
Received: from xdsl-213-168-117-12.netcologne.de ([213.168.117.12]:40592 "EHLO
	t-stueck.streichelzoo") by vger.kernel.org with ESMTP
	id <S288814AbSA3Hyr>; Wed, 30 Jan 2002 02:54:47 -0500
Date: Wed, 30 Jan 2002 08:54:44 +0100
From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: Configure.help in 2.5.3-pre6
Message-ID: <20020130075444.GA401@hydra>
In-Reply-To: <Pine.LNX.4.33.0201292147530.22800-100000@barbarella.hawaga.org.uk> <1012370595.3392.21.camel@phantasy> <a3847v$17m$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3847v$17m$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 06:35:43AM +0000, Linus Torvalds wrote:
> >config' works.  The new per-config.in config.help is here to stay.
should be more easy to maintain - should make eric more happy

> Yes. On the other hand, if there are real problems with converting
> menu/x config to multiple help-files, a short-term answer might indeed
> be just the silly "concatenate everything into the same file".
short being between now and the cml2 inclusion?

> I'd much _prefer_ to have somebody who knows menuconfug/xconfig (or just
> wants to learn).  I have a totally untested patch for menuconfig, that
> probably just works (like the regular config thing it doesn't actualy
> take _advantage_ of pairing the Config.help files up with the questions,
> but at least it should give you the help texts like it used to). 
hmm... maybe that's a good place to finally drop cml1? given that cml2
copes with that new help-format that is *hint*

patrick mauritz
(starting an old discussion again)
-- 
             I disapprove of what you say, but I will defend
                  your right to say it with all my might
