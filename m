Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131930AbQKZX6D>; Sun, 26 Nov 2000 18:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132097AbQKZX5z>; Sun, 26 Nov 2000 18:57:55 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41487 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S131930AbQKZX5m>; Sun, 26 Nov 2000 18:57:42 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Date: 26 Nov 2000 15:27:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vs695$oht$1@cesium.transmeta.com>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E140AZB-0002Qh-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > +		{"ignore-versions", 0, 0, 'i'},
> 
> I dont think we should encourage anyone to ignore symbol versions
> 

No, but sometimes you really want to be able to.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
