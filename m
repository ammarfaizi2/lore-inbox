Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280682AbRKNQ3E>; Wed, 14 Nov 2001 11:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280683AbRKNQ2x>; Wed, 14 Nov 2001 11:28:53 -0500
Received: from sun.fadata.bg ([80.72.64.67]:26123 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S280680AbRKNQ2h>;
	Wed, 14 Nov 2001 11:28:37 -0500
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: Matthew Sell <msell@ontimesupport.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141607170.14971-100000@gurney>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.GSO.4.33.0111141607170.14971-100000@gurney>
Date: 14 Nov 2001 18:28:44 +0200
Message-ID: <87zo5p5nb7.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alastair" == Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> writes:

Alastair>   - Red Hat Kernel (any) boots fine, hangs at login prompt
Alastair>   - Red Hat Kernel SINGLE USER runs fine and lets me hack around
Alastair>   - Custom kernel (2.4.15-pre4 SMP) hangs due to failing to
Alastair>     mount the root partition (initrd issue I think)

Make sure filesystem is ok.  I had hangups at the login prompt and xdm
due to bogus utmp (or wtmp).

Regards,
-velco

