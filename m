Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBIJpF>; Sun, 9 Feb 2003 04:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBIJpF>; Sun, 9 Feb 2003 04:45:05 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:60631 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267180AbTBIJpE>; Sun, 9 Feb 2003 04:45:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 3c509 driver doesn't compile in 2.5.59
References: <Pine.LNX.4.30.0302090957570.12534-100000@ghost.cybernet.cz>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
In-Reply-To: <Pine.LNX.4.30.0302090957570.12534-100000@ghost.cybernet.cz>
Date: 09 Feb 2003 10:54:22 +0100
Message-ID: <wrp1y2hwzht.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "brain" == brain  <brain@artax.karlin.mff.cuni.cz> writes:

brain> Hello.
brain> When I turn on 3c509 support in 2.5.59 kernel and try to compile, I get:

[snip]

You need to update to the latest BK patches (so you get the MCA
stuff), and then apply the patch I sent to the list yesterday.

brain> I'm not able to attach my config file because you'r mailing
brain> system rejects the mail even when I put the config into body of
brain> the message.

Nope. Your messages made it to the list, 4 times.
The messages you get is from some very annoying badly configured
machine from linuxgroup.net, which hit me twice yesterday...

        M.
-- 
Places change, faces change. Life is so very strange.
