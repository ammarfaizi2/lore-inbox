Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271473AbRHZTVQ>; Sun, 26 Aug 2001 15:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271486AbRHZTVG>; Sun, 26 Aug 2001 15:21:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271473AbRHZTUx>; Sun, 26 Aug 2001 15:20:53 -0400
Subject: Re: VCool - cool your Athlon/Duron during idle
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Sun, 26 Aug 2001 20:24:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org> from "Dieter =?iso-8859-1?q?N=FCtzel?=" at Aug 26, 2001 08:09:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15b5W8-0002cC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you read something about this Athlon/Duron cooling problem?
> Can this code included into your (and/or the official) tree?
> Maybe it is needed for the AMD 750/760/760MP/760MPX, too?

Well my German isnt that good, but it appears to be just another variant
on CPU idling. We do hlt or APM already, and APM should be doing other
work if appropriate.

Alan
