Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWEUAex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWEUAex (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWEUAex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:34:53 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:7684 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932249AbWEUAex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:34:53 -0400
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Harald Welte <laforge@netfilter.org>
Subject: Re: Linux 2.6.16.17
References: <20060520230912.GJ23243@moss.sous-sol.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Sun, 21 May 2006 01:33:54 +0100
In-Reply-To: <20060520230912.GJ23243@moss.sous-sol.org> (Chris Wright's message of "21 May 2006 00:07:25 +0100")
Message-ID: <87fyj4fc7h.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2006, Chris Wright announced:
> Harald Welte:
>       Fix udev device creation

As an aside, patches Cc:ed to stable that concern only a few specific
drivers should probably mention the driver in the short changelog;
e.g. this is specific to cm4000_cs.

(Anyone who really cares about system stability and isn't running a
distro kernel should probably be checking things at the review phase
anyway, so this is rather pedantic of me and may not actually affect
anyone. As a mere user I'm very impressed with the -stable process; many
other projects could do with something like it.)

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
