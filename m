Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282703AbRK0BFo>; Mon, 26 Nov 2001 20:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRK0BFh>; Mon, 26 Nov 2001 20:05:37 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:5761 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282703AbRK0BFX>; Mon, 26 Nov 2001 20:05:23 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200111270101.BAA01290@mauve.demon.co.uk>
Subject: Re: Journaling pointless with today's hard disks?
To: jlundell@pobox.com (Jonathan Lundell)
Date: Tue, 27 Nov 2001 01:01:19 +0000 (GMT)
Cc: nitrax@giron.wox.org (Martin Eriksson),
        xioborg@yahoo.com (Steve Brueggeman), linux-kernel@vger.kernel.org
In-Reply-To: <p05100301b82887aff497@[207.213.214.37]> from "Jonathan Lundell" at Nov 26, 2001 04:18:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> At 12:49 AM +0100 11/27/01, Martin Eriksson wrote:
> >I sure think the drives could afford the teeny-weeny cost of a power failure
<snip>
> converter, which is expensive. If you simply detect a drop in dc 
> power, there simply isn't enough margin to reliably write a block.
> 
> Years (many years) back, Diablo had a short-lived model (400, IIRC) 
> that had an interesting twist on this. On a power failure, the 
> spinning disk (this was in the days of 14" platters, so plenty of 
> energy) drove the spindle motor as a generator, providing power to 
> the drive electronics for several seconds before it spun down to 
> below operating speed.

I have a (IIRC) elantec databook from 1985 or so, that I've found chips in
disks from the MFM/RLL PC era. 
These are motor driver chips aimed at PCs, which support generation 
using the motor.
