Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264119AbRFFToz>; Wed, 6 Jun 2001 15:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbRFFTop>; Wed, 6 Jun 2001 15:44:45 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:49379 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S264119AbRFFTog>; Wed, 6 Jun 2001 15:44:36 -0400
Date: Wed, 6 Jun 2001 15:44:22 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: ethernet and pointopoint
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F26@mail-in.comverse-in.com>
Message-ID: <Pine.GSO.4.33.0106061539061.18152-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
Content-Type-X: multipart/mixed; boundary="------------3897B7E0F65FF08A89ED6C92"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Adam [mailto:adam@cfar.umd.edu]
> > 	Is there reason why I can't set pointopoint for ethernet? I have
>
> If your network cards & their drivers (both hosts) support full duplex
> operation, just enable it, and you're done.

did you read my email? The patch below has detailed description of the
problem and suggested solution. Still I'm not quite sure if that's the
"the way it should be"(tm), so I'm hoping on more feedback on the issue
itself.

http://www.eax.com/patches/linux-kernel-dev2-diff

-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers

