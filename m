Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310492AbSCCA4H>; Sat, 2 Mar 2002 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310493AbSCCAzy>; Sat, 2 Mar 2002 19:55:54 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:41733
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S310492AbSCCAzl>; Sat, 2 Mar 2002 19:55:41 -0500
Message-Id: <5.1.0.14.2.20020302195020.01d0c948@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 02 Mar 2002 19:50:45 -0500
To: erich@uruk.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
Cc: ja@ssi.bg (Julian Anastasov), szekeres@lhsystems.hu (Szekeres Bela),
        dang@fprintf.net (Daniel Gryniewicz),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <E16hFeV-0000Nj-00@trillium-hollow.org>
In-Reply-To: <Your message of "Sat, 02 Mar 2002 19:14:55 GMT." <E16hEy7-000875-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:58 AM 3/2/2002 -0800, erich@uruk.org wrote:

>I would think that making the IP stack, for each MAC/interface path
>on reception, just check against the exact expected input address,
>would actually be a performance improvement on machines with multiple
>NICs.

Two words: Broadcast addresses.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

