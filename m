Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280034AbRKDRTT>; Sun, 4 Nov 2001 12:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKDRTI>; Sun, 4 Nov 2001 12:19:08 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:53016 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S280034AbRKDRS6>; Sun, 4 Nov 2001 12:18:58 -0500
Date: Sun, 4 Nov 2001 18:18:25 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Rui Sousa <rui.p.m.sousa@clix.pt>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>, <kwijibo@zianet.com>,
        <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: emu10k emits buzzing and crackling
In-Reply-To: <3BE572DC.4BD4958E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111041813310.3150-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Jeff Garzik wrote:

> Rui Sousa wrote:
> > With the emu10k1 there is no need to use esd...
> 
> emu10k1 provides in-kernel support for multiple userspace apps sharing a
> single /dev/dsp0 connection?  :)

Yes. :) :)

> 
> GNOME pretty much requires esd, like KDE requires arts.

For most common sound cards. Not when you can have 32 independent stereo 
sound streams.

Rui

