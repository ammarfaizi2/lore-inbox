Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQKOW22>; Wed, 15 Nov 2000 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKOW2T>; Wed, 15 Nov 2000 17:28:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32526 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129190AbQKOW2G>; Wed, 15 Nov 2000 17:28:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New bluesmoke patch available, implements MCE-without-MCA support
Date: 15 Nov 2000 13:57:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uv0sr$2lv$1@cesium.transmeta.com>
In-Reply-To: <8uuvnk$1v8$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <8uuvnk$1v8$1@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
>
> Hi everyone,
> 
> I have just released a second bluesmoke patch:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/bluesmoke-2.4.0-test11-pre5-2.diff
> 
> This implements support for MCE on chips which don't support MCA (in
> addition to enabling MCA for non-Intel chips, like Athlon, which
> supports MCA.)
> 
> I would appreciate it if people who have chips with MCE but no MCA --
> this includes older AMD chips and some Cyrix chips at the very least
> -- would please be so kind and try this out.
> 

Me bad... I accidentally let a one-character typo (missing & sign)
in... I have generated a -3 version of this patch.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
