Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQLFUfz>; Wed, 6 Dec 2000 15:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQLFUff>; Wed, 6 Dec 2000 15:35:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64266 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130105AbQLFUf2>; Wed, 6 Dec 2000 15:35:28 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trashing ext2 with hdparm
Date: 6 Dec 2000 12:04:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90m650$1oe$1@cesium.transmeta.com>
In-Reply-To: <3A2E98E1.9B9732E4@Hell.WH8.TU-Dresden.De> <Pine.LNX.4.10.10012061156190.21407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10012061156190.21407-100000@master.linux-ide.org>
By author:    Andre Hedrick <andre@linux-ide.org>
In newsgroup: linux.dev.kernel
> 
> Did you set and mount a "/var/shm" point?
> 

<HARP>
Please don't use the path /var/shm... it was a really bad precedent
set when someone suggested it.  Use /dev/shm.
</HARP>

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
