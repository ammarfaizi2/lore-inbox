Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUAXMuU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266935AbUAXMuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:50:20 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:43237 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266925AbUAXMuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:50:16 -0500
Date: Sat, 24 Jan 2004 13:46:11 +0100 (CET)
From: Ingo Buescher <gallatin@gmx.net>
X-X-Sender: gallatin@nathan.cybernetics.com
To: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.3
In-Reply-To: <4011AC22.8050903@planet.nl>
Message-ID: <Pine.LNX.4.58.0401241343200.11829@anguna.ploreargvpf.pbz>
References: <20040123145048.B1082@beton.cybernet.src>
 <20040123100035.73bee41f.jeremy@kerneltrap.org> <20040123151340.B1130@beton.cybernet.src>
 <001b01c3e1ca$26101f20$1e00000a@black> <20040123163008.B1237@beton.cybernet.src>
 <1074882836.20723.4.camel@minerva> <4011AC22.8050903@planet.nl>
X-Binford: 6100 (more power)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Stef van der Made wrote:

> Matthew Reppert wrote:
> Same here. I've been using gcc3.2.0 and beyond currently 3.3.2 since the
> day they were released and never had any big issues. I would recomend
> using gcc 3.3.2 since it improves performance when using optimizations
> quite a bit as far as I can remember the statistics.
>


> Stef

Well, according to this list, gcc-3.3.2 at least has problems to compile
ALSA correctly, unless you activate framepointer support.

IB
-- 
"For every government X there is at least one government Y such that X
would claim that Y is a bunch of corrupt assholes.  Since every government
is  a bunch of corrupt assholes, every government is right at least in
one of its claims." -- Al Viro discussing politics on lkml
