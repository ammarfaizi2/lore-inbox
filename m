Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273816AbRIXMZM>; Mon, 24 Sep 2001 08:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273870AbRIXMYw>; Mon, 24 Sep 2001 08:24:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273816AbRIXMYp>; Mon, 24 Sep 2001 08:24:45 -0400
Subject: Re: [PATCH] Enable SSE on K7's with old/broken BIOS's.
To: john@deater.net (John Clemens)
Date: Mon, 24 Sep 2001 13:29:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109240106440.6419-100000@pianoman.cluster.toy> from "John Clemens" at Sep 24, 2001 01:19:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lUrm-0002L3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It enables SSE support on Athlon4/MP/XP (later model) Athlon's if the BIOS
> does not.  This is done by zero-ing bit 15 of the Athlon's HWCR.  The
> patch has been tested for a few days by me and a few other people with
> AthlonMP's and Athlon4's, with no negative reports.

Please submit it via Dave Jones <davej@suse.de>. He is the keeper of most
of the setup code and also has Athlon bios info and contacts with AMD
for stuff
