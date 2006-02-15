Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWBOA0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWBOA0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 19:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWBOA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 19:26:51 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35528
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1422893AbWBOA0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 19:26:51 -0500
From: Rob Landley <rob@landley.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 19:26:45 -0500
User-Agent: KMail/1.8.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060214232401.GA83161@dspnet.fr.eu.org>
In-Reply-To: <20060214232401.GA83161@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141926.45359.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 6:24 pm, Olivier Galibert wrote:
> There may be a chance that cdrdao provides a better starting point,
> readability-wise.  It seems to be simpler in what it does, and I've
> tended to have a better success rate with it than with cdrecord on
> "normal" usage.  Of course, it does not (or did not) include the
> advanced usage cdrecord supports (various writing modes, multisession,
> who knows what else).

I wanna go:

./busybox cdwrite filename.iso /dev/cdrom

And:

./busybox cdwrite -e

To blank a rewriteable.

Anything else is gravy, pretty much...

>   OG.

Rob
-- 
Never bet against the cheap plastic solution.
