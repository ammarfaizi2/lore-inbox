Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbRBLXyG>; Mon, 12 Feb 2001 18:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRBLXx4>; Mon, 12 Feb 2001 18:53:56 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:41232 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129738AbRBLXxq>; Mon, 12 Feb 2001 18:53:46 -0500
Date: Mon, 12 Feb 2001 11:21:34 +0100
From: Kurt Garloff <kurt@garloff.de>
To: linux-kernel@vger.kernel.org
Subject: Re: dc295
Message-ID: <20010212112134.B1027@garloff.etpnet.phys.tue.nl>
In-Reply-To: <m3bssa8qb2.fsf@h0050bad6338d.ne.mediaone.net>
Mime-Version: 1.0
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3bssa8qb2.fsf@h0050bad6338d.ne.mediaone.net>; from nick@coelacanth.com on Sat, Feb 10, 2001 at 11:18:25AM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Feb 10, 2001 at 11:18:25AM -0500, Nick Papadonis wrote:
> I saw a posting about the DC-395 from you.
> 
> What the current state of the driver?  Where is it? =20

http://www.garloff.de/kurt/linux/dc395/

Works perfectly for most people, but corrupts data for some.

> I just bought the card thinking a Linux driver was available, but one
> doesn't appear to be in the 2.4 kernel tree.

I won't push it into the kernel with the "corruption for a few" feature.
Data loss is not what you expect from your Linux.
And it's hard to fix without any reasonable chipset docu.

> Any insight appreciated.

Regards,
-- 
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
