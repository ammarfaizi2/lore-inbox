Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbUADLU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUADLU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:20:27 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:52223 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265392AbUADLUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:20:22 -0500
Date: Sun, 4 Jan 2004 03:20:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, Lincoln Dale <ltd@cisco.com>,
       Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104112000.GP1882@matchmail.com>
Mail-Followup-To: Soeren Sonnenburg <kernel@nn7.de>,
	Nick Piggin <piggin@cyberone.com.au>, Lincoln Dale <ltd@cisco.com>,
	Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <1073211879.3261.6.camel@localhost> <20040104111257.GO1882@matchmail.com> <1073215029.3247.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073215029.3247.13.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 12:17:10PM +0100, Soeren Sonnenburg wrote:
> Says me, as quite a lot of stuff does not apply cleanly... and probably
> same with when applying -mm1.

Does -mm1 compile on ppc for you?

If not, then post some compile errors to the list...
