Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSGCLmy>; Wed, 3 Jul 2002 07:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSGCLmx>; Wed, 3 Jul 2002 07:42:53 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:47428 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S317002AbSGCLmw>; Wed, 3 Jul 2002 07:42:52 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: khromy@lnuxlab.ath.cx (khromy)
Date: Wed, 3 Jul 2002 13:43:53 +0200
MIME-Version: 1.0
Subject: Re: sync slowness. ext3 on VIA vt82c686b
CC: linux-kernel@vger.kernel.org
Message-ID: <3D22FF99.20201.56824C@localhost>
In-reply-to: <20020703094031.GA4462@lnuxlab.ath.cx>
References: <20020703102244.B2491@redhat.com>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I would test that Maxtor disk with their Powermax tool, i were you. 
And asap. 


/Pedro

On 3 Jul 2002 at 5:40, khromy wrote:

> 
> Yeah, /home/ is on the same disk.  Your guess might be right because
> that's what I was trying to show.  When I copy the file, which is in
> /home/(hda2) to /tmp/(hda1) and I sync, it takes almost 2 minutes. 
> But if I copy the same file, which is in /home/(hda2) to
> /usr/local/(hda3), sync returns immediately.  This disk isn't that old
> either.
> 
> hda: Maxtor 51536U3, ATA DISK drive
> hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63,
> UDMA(66)
> 
> -- 
> L1:	khromy		;khromy(at)lnuxlab.ath.cx
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


