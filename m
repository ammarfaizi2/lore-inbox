Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281737AbRKULmW>; Wed, 21 Nov 2001 06:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281732AbRKULmM>; Wed, 21 Nov 2001 06:42:12 -0500
Received: from ns.suse.de ([213.95.15.193]:18181 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281724AbRKULmD>;
	Wed, 21 Nov 2001 06:42:03 -0500
Date: Wed, 21 Nov 2001 12:42:02 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <20011121122034.B9978@suse.de>
Message-ID: <Pine.LNX.4.33.0111211240220.4080-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Jens Axboe wrote:

> No there is a bug there, I can confirm that mine does the same (ie
> second athlon is not reported with correct model name)

Interesting. But they are definitly the same CPU models ?
x86info -a info please ? (pub/people/davej on ftp.suse.com)

Could be your BIOS isn't setting up 2nd CPU name string.
Harmless, but dumb.  If this is the case, I wonder what else
it forgets to do.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

