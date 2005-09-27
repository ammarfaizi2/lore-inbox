Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVI0OwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVI0OwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVI0OwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:52:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12223 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964957AbVI0OwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:52:24 -0400
Subject: Re: Audigy2 renamed, grrr...
From: Lee Revell <rlrevell@joe-job.com>
To: Stl <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4338EF9A.1080906@poczta.fm>
References: <4338EF9A.1080906@poczta.fm>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 10:49:15 -0400
Message-Id: <1127832555.1326.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 09:07 +0200, Stl wrote:
> Grrreetings.
> 
> Why the hell, Audigy2's name in alsa driver changes with every kernel
> version? Who is such a lunatic to revert it once every two months,
> from Audigy 2 ZS to SB350, from SB350 back to Audigy2 (why not ZS? I've
> got ZS!).
> 
> Hey guys make up yout minds or don't touch it at all. Once you fill like
> touching it lie down and wait until it goes away.
> 

These changes were required to support the increasingly wide variety of
emu10k1 based hardware.

Anyway it should not matter - newer versions of alsactl will still be
able to restore the mixer settings.

Lee

