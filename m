Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRIERcs>; Wed, 5 Sep 2001 13:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272245AbRIERch>; Wed, 5 Sep 2001 13:32:37 -0400
Received: from scispor.dolphinics.no ([193.71.152.117]:19986 "EHLO
	scispor.dolphinics.no") by vger.kernel.org with ESMTP
	id <S272242AbRIERc0> convert rfc822-to-8bit; Wed, 5 Sep 2001 13:32:26 -0400
Message-ID: <200109051937150093.38F8B7ED@scispor.dolphinics.no>
In-Reply-To: <JK3MT4ZNAEJNIG1ZEGEDMAZMT10XZKMHVJEFFMME@ziplip.com>
In-Reply-To: <JK3MT4ZNAEJNIG1ZEGEDMAZMT10XZKMHVJEFFMME@ziplip.com>
X-Mailer: Calypso Version 3.00.03.02 (1)
Date: Wed, 05 Sep 2001 19:37:15 +0200
From: "Simen Thoresen" <simen-tt@online.no>
To: "noneuclidean" <noneuclidean@ziplip.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Athlon doesn't like Athlon optimisation?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamal Conway wrote
>I think the burnK7 program does not test enough K7 specific instruction sets to find the problem.
>

I tend to agree; 30+ minutes on a Epox 8KTA3 motherboard with a processor that fails when running with Athlon-optimized fast_copy_page (now running without that), without a hitch.

-S
--
Simen Thoresen, Beowulf-cleaner and random artist - close and personal.

Er det ikke rart?
The gnu RART-project on http://valinor.dolphinics.no:1080/~simentt/rart


