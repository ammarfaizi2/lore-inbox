Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290163AbSAKX32>; Fri, 11 Jan 2002 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290164AbSAKX3T>; Fri, 11 Jan 2002 18:29:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60170 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290163AbSAKX3F>; Fri, 11 Jan 2002 18:29:05 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Fri, 11 Jan 2002 23:40:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rth@twiddle.net (Richard Henderson),
        Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201112326.g0BNQvR318985@saturn.cs.uml.edu> from "Albert D. Cahalan" at Jan 11, 2002 06:26:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PBHj-0000hV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that are hard to defy. Don't worry about it. Intel will
> never produce a new x86-compatible chip without cmov.
> Nobody else will either.

People already do. The C3 and C5. The fact the real world i686 definition
and the compiler one differed caused much pain in the package installing
department.

Alan
