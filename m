Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRKNDM3>; Tue, 13 Nov 2001 22:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKNDMU>; Tue, 13 Nov 2001 22:12:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51853 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280034AbRKNDMH>;
	Tue, 13 Nov 2001 22:12:07 -0500
Date: Tue, 13 Nov 2001 19:11:56 -0800 (PST)
Message-Id: <20011113.191156.24648525.davem@redhat.com>
To: goemon@anime.net
Cc: hiryuu@envisiongames.net, calin@ajvar.org, nitrax@giron.wox.org,
        linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111131904220.9591-100000@anime.net>
In-Reply-To: <20011113.183256.15406047.davem@redhat.com>
	<Pine.LNX.4.30.0111131904220.9591-100000@anime.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Hollis <goemon@anime.net>
   Date: Tue, 13 Nov 2001 19:05:11 -0800 (PST)

   On Tue, 13 Nov 2001, David S. Miller wrote:
   > Try to use the AGP slot with a Radeon of GeForce card, do something
   > as simple as playing some quake with com_maxfps > 85 and the machine
   > will hang solidly.
   
   I thought there was a northbridge configuration workaroud for this errata.
   (And no smarty pants replies like "yeah, dont use AGP")
   
No, the AMD761 AGP problems have no known fixes (outside of AMD).
AMD's windows drivers have the workarounds.
