Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQKOWDT>; Wed, 15 Nov 2000 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbQKOWDK>; Wed, 15 Nov 2000 17:03:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39181 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129523AbQKOWC5>; Wed, 15 Nov 2000 17:02:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: test11-pre5, Athlon, and Machine Check Architecture
Date: 15 Nov 2000 13:32:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uuvdp$1t4$1@cesium.transmeta.com>
In-Reply-To: <8uuqij$ejs$1@cesium.transmeta.com> <200011152114.WAA06084@cave.bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011152114.WAA06084@cave.bitwizard.nl>
By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
In newsgroup: linux.dev.kernel
>
> H. Peter Anvin wrote:
> > crash; I don't expect anyone to actually see an #MF exception in real
> > life.  I'm trying to get confirmation from AMD that the code should
> > be correct even for Athlon.
> 
> Peter, 
> 
> Would it be an idea to invite people to lower the voltage on their 
> CPUs a bit, to try and trigger #MF's?
> 
> (I started thinking about slowly overclocking the CPUs, to try and
> trigger them, but that's not neccesary. At lower voltages, you'll also
> get errors, but shouldn't risk smoking your CPU.... )
> 

If they wouldn't mind, I certainly would appreciate it... but on the
other hand, once you have gotten an #MF you have no guarantee of
proper operation anyway... after all, the code itself could be
corrupt.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
