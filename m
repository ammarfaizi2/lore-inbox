Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271467AbRHTRYA>; Mon, 20 Aug 2001 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271468AbRHTRXu>; Mon, 20 Aug 2001 13:23:50 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:5892 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S271467AbRHTRXa>;
	Mon, 20 Aug 2001 13:23:30 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108201723.TAA01855@nbd.it.uc3m.es>
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <20010820182138.C26054@oisec.net> "from Cliff Albert at Aug 20,
 2001 06:21:38 pm"
To: Cliff Albert <cliff@oisec.net>
Date: Mon, 20 Aug 2001 19:23:31 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Cliff Albert wrote:"
> On Mon, Aug 20, 2001 at 11:37:33AM +0100, Alan Cox wrote:
> > There is a known BIOS irq routing table problem with a large number of Intel
> > BIOS boards with onboard adaptec controllers. The fact that making it use
> > the io-apic works suggest this is the same thing.
> 
> It's an ASUS P2B-S board with a Award Bios, flashed to the latest revision that
> is available from ASUS

I have exactly the same machine somewhere (will search, later) with onboard scsi.
I believe it's currently running 2.4.3 with apic enabled with only occasional
(weekly) troubles.

I'll see if I can dig it out and test it.

Peter
