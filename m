Return-Path: <linux-kernel-owner+w=401wt.eu-S932117AbXAOIkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXAOIkR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbXAOIkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:40:17 -0500
Received: from stinky.trash.net ([213.144.137.162]:53046 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXAOIkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:40:15 -0500
Message-ID: <45AB3DED.8090404@trash.net>
Date: Mon, 15 Jan 2007 09:40:13 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Madore <david.madore@ens.fr>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
References: <20070114192011.GA6270@clipper.ens.fr> <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr> <20070115003508.GA8085@clipper.ens.fr>
In-Reply-To: <20070115003508.GA8085@clipper.ens.fr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore wrote:
> On Sun, Jan 14, 2007 at 09:10:45PM +0100, Jan Engelhardt wrote:
> 
>>On Jan 14 2007 20:20, David Madore wrote:
>>
>>>Implement TCPMSS target for IPv6 by shamelessly copying from
>>>Marc Boucher's IPv4 implementation.
>>
>>Would not it be worthwhile to merge ipt_TCPMSS and
>>ip6t_TCPMSS to xt_TCPMSS instead?
> 
> 
> It may be, but I'm afraid that's outside my competence.  I happened to
> need ip6t_TCPMSS badly and soon, so I went for the quickest solution.
> Of course, I'd appreciate it if someone were to do it in a better way.

I'll give it a shot.

