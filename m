Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQKGXZT>; Tue, 7 Nov 2000 18:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbQKGXZK>; Tue, 7 Nov 2000 18:25:10 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:16462 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129507AbQKGXYw>; Tue, 7 Nov 2000 18:24:52 -0500
Date: Wed, 8 Nov 2000 01:32:42 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: xterm: no available ptys
In-Reply-To: <8u7ibn$g5e$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011080131200.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm missing ptmx. You NEED a writable /dev/pts dir.
> > 
> 
> Actually, what you need is the devpts filesystem mounted onto
> /dev/pts.

Agree. I had a shitload of probs when 2.2.0 came out and I switched.. Was
due that /dev was readonly here. Bit strange if I think of it. 

> 
> 	-hpa
> 


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
