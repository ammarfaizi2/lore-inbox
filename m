Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbRERGgR>; Fri, 18 May 2001 02:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262259AbRERGgH>; Fri, 18 May 2001 02:36:07 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:7691 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S262256AbRERGf6>; Fri, 18 May 2001 02:35:58 -0400
Date: Fri, 18 May 2001 08:40:35 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: <linux-kernel@vger.kernel.org>
Subject: [SCSI TAPE CORRUPTION] - AARGH... it's even on CDWR!
Message-ID: <Pine.WNT.4.31.0105180840100.65-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yesterday, I burnt some deployment CD for W98SE (yes, THAT thing...),
about 400 megs of stuff. And they DIDN'T work.

dd'ed the image from the cd device, then compared with the original
(luckily I had still it on my HDD)....

32 defective bytes !!! from 32KB before :(((

Note that I've never suffered from HD corruption.

Maybe something on SCSI character devices?

Crying...
				-- Lorenzo Marcantonio



