Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbRENRKR>; Mon, 14 May 2001 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbRENRKH>; Mon, 14 May 2001 13:10:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262322AbRENRJr>; Mon, 14 May 2001 13:09:47 -0400
Subject: Re: Not a typewriter
To: meissner@spectacle-pond.org (Michael Meissner)
Date: Mon, 14 May 2001 18:01:42 +0100 (BST)
Cc: vonbrand@sleipnir.valparaiso.cl (Horst von Brand),
        mharris@opensourceadvocate.org (Mike A. Harris), Wayne.Brown@altec.com,
        hacksaw@hacksaw.org (Hacksaw),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <20010514112554.A10909@munchkin.spectacle-pond.org> from "Michael Meissner" at May 14, 2001 11:25:54 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zLj4-0000zO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC, the 6 character linker requirement came from when the Bell Labs folk
> ported the C compiler the IBM mainframe world, not from the early UNIX (tm)
> world.  During the original ANSI C meetings, I got the sense from the IBM rep,

6 character linker name limits are very old. Honeywell L66 GCOS3/TSS which I
had the dubious pleasure of experiencing and which is a direct derivative of
GECOS and thus relevant to the era like many 36bit boxes uses 6 char link names

Why - well because 6 BCD characters fit in a 36bit word and its a single compare
to check symbol matches

