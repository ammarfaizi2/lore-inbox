Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLOSwa>; Fri, 15 Dec 2000 13:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLOSwV>; Fri, 15 Dec 2000 13:52:21 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:10215 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129437AbQLOSwK>; Fri, 15 Dec 2000 13:52:10 -0500
Date: Fri, 15 Dec 2000 20:21:01 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, e.jokisch@u-code.de,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: test12 lockups -- need feedback
Message-ID: <20001215202101.N829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <1368.195.67.189.102.976902742.squirrel@www.zytor.com> <E146zG2-0001bG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E146zG2-0001bG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 15, 2000 at 06:06:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 06:06:58PM +0000, Alan Cox wrote:
> > > This was on Cyrix III.
> > Please include the oops information, as well as the /proc/cpuinfo output.
> Also be sure you built Pentium/TSC kernels as Cyrix III is a 686 core without
> the cmov instruction it seems

I did. And built with gcc 2.95.2 (debian potato) if that matters.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
