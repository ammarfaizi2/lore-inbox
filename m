Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTA3DAj>; Wed, 29 Jan 2003 22:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTA3DAj>; Wed, 29 Jan 2003 22:00:39 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:48516 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267374AbTA3DAi>;
	Wed, 29 Jan 2003 22:00:38 -0500
Date: Wed, 29 Jan 2003 22:12:34 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
Message-ID: <20030129221234.GC2246@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301271534210.2937-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301271534210.2937-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 03:36:41PM +0100, Jaroslav Kysela wrote:
>
> Any notes?

Actually I was wondering if you could provide some further information about the 
nature of these multidevice sound cards so I can better understand the 
situation.

1.)  How are the componets of a typical card divided among the sub-devices. (ex: 
control, mpu, wave table, etc)

2.)  Are all the devices required for the card to properly function, in other 
words, must the card always have possession of all of the sound related 
sub-devices in order to function at a minimal level.

3.)  Are there any other isapnp cards that depend on multiple devices per 
driver, to my knowledge only a limited set of sound cards do.

Thanks,
Adam
