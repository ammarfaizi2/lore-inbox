Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136598AbRASBSW>; Thu, 18 Jan 2001 20:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136599AbRASBSM>; Thu, 18 Jan 2001 20:18:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136598AbRASBSJ>; Thu, 18 Jan 2001 20:18:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Date: 18 Jan 2001 17:17:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9484jr$qud$1@cesium.transmeta.com>
In-Reply-To: <3A656C09.4A40BBF5@mandrakesoft.com> <200101162111.f0GLBNb14141@webber.adilger.net> <20276.979724327@redhat.com> <13466.979725727@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <13466.979725727@redhat.com>
By author:    David Woodhouse <dwmw2@infradead.org>
In newsgroup: linux.dev.kernel
> 
> There are 2.2 patches to do it, which I think are now being dusted off and 
> resurrected. but scanning for UUID involves poking at every partition on 
> every available hard drive.
> 

The kernel does that anyway, so what's the problem, really?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
