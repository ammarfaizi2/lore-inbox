Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbRFPNjm>; Sat, 16 Jun 2001 09:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbRFPNjd>; Sat, 16 Jun 2001 09:39:33 -0400
Received: from ns.caldera.de ([212.34.180.1]:45763 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S264625AbRFPNjW>;
	Sat, 16 Jun 2001 09:39:22 -0400
Date: Sat, 16 Jun 2001 15:38:11 +0200
Message-Id: <200106161338.f5GDcB413330@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps2 keyboard filter hook
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <UTC200106161253.OAA311473.aeb@vlet.cwi.nl>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UTC200106161253.OAA311473.aeb@vlet.cwi.nl> you wrote:
> One of these centuries we must replace the present keyboard
> and console stuff, probably by something very similar to
> Vojtech's input device stuff, and we must make sure that
> the new code is powerful enough to last for a few years again.

Why only something similar to the input suite and not the (full)
input suite?  It works really nice here and unlike the current
keyboard cruft it is actually very clean.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
