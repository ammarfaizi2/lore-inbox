Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRI3BiI>; Sat, 29 Sep 2001 21:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272295AbRI3Bh5>; Sat, 29 Sep 2001 21:37:57 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:8967
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S272265AbRI3Bhx>; Sat, 29 Sep 2001 21:37:53 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109300119.f8U1JW319524@www.hockin.org>
Subject: Re: [PATCH] fixes for the natsemi driver
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sat, 29 Sep 2001 18:19:32 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        arjan@fenrus.demon.nl, thockin@sun.com (Tim Hockin)
In-Reply-To: <3BB6593B.CEDDD523@colorfullife.com> from "Manfred Spraul" at Sep 30, 2001 01:29:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * stop the nic before switching into silent rx mode for wol (required
> according to docu).
> 
> Patch against 2.4.10. WOL is not tested, but ifup, ifdown, suspend and
> resume during flood ping now work.

I have a largish patch pending, too. I apologize for delaying - I'll get it
out ASAP (next week @ work).

Tim
