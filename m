Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272472AbRIKOnQ>; Tue, 11 Sep 2001 10:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268017AbRIKOnG>; Tue, 11 Sep 2001 10:43:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35333 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272462AbRIKOmt>; Tue, 11 Sep 2001 10:42:49 -0400
Subject: Re: Duron kernel crash (i686 works)
To: drebes@inf.ufrgs.br (Roberto Jung Drebes)
Date: Tue, 11 Sep 2001 15:47:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109102207010.24461-100000@jacui> from "Roberto Jung Drebes" at Sep 10, 2001 10:11:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15goos-0002le-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo KT133A
> chipset). The kernel I had (2.4.9) started crashing on boot with an
> invalid page fault, usually right after starting init. I tryed a i686
> kernel and noticed it works OK, so I recompiled my crashy kernel only
>
> Anyone else experiencing this?

Several reports. Back down the BIOS version
