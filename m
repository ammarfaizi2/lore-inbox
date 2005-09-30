Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVI3MyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVI3MyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVI3MyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:54:23 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:45190 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751302AbVI3MyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:54:22 -0400
Date: Fri, 30 Sep 2005 08:53:09 -0400
From: Mathieu Chouquet-Stringer <ml2news@optonline.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: Audigy2 renamed, grrr...
In-reply-to: <s5hachun2rk.wl%tiwai@suse.de>
To: tiwai@suse.de (Takashi Iwai)
Cc: rlrevell@joe-job.com (Lee Revell), linux-kernel@vger.kernel.org,
       Stl <stlman@poczta.fm>
Message-id: <m3zmpuwwcq.fsf@mcs.bigip.mine.nu>
Organization: Uh?
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
References: <4338EF9A.1080906@poczta.fm> <1127832555.1326.5.camel@mindpipe>
 <s5hachun2rk.wl%tiwai@suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tiwai@suse.de (Takashi Iwai) writes:
> The patch below should fix the problem.  Give it a try.

I will thanks (basically I had temporarily fixed the driver by re-adding
the .ac97_chip = 1 line).

I'll give yours a whirl and I'll let you know how it went.
 
-- 
Mathieu Chouquet-Stringer
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --
