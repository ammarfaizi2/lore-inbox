Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281912AbRKUPr5>; Wed, 21 Nov 2001 10:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281905AbRKUPrs>; Wed, 21 Nov 2001 10:47:48 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:20238 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S281912AbRKUPrh>;
	Wed, 21 Nov 2001 10:47:37 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15355.52367.747990.149824@abasin.nj.nec.com>
Date: Wed, 21 Nov 2001 10:47:27 -0500 (EST)
To: Jorge Nerin <comandante@zaralinux.com>
Cc: Sven Heinicke <sven@research.nj.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/stat description for proc.txt
In-Reply-To: <3BFAE0FD.8010909@zaralinux.com>
In-Reply-To: <15347.57175.887835.525156@abasin.nj.nec.com>
	<3BFAE0FD.8010909@zaralinux.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yea, well, I didn't get any message about my proc.txt patch going into
the kernel.  So it's back to the source I guess. :(

    Sven

Jorge Nerin writes:
 > Sven Heinicke wrote:
 > 
 > > I got tired at looking proc_misc.c to see what /proc/stat was
 > > reporting about.  So here is my noted patched into proc.txt about the
 > > /proc/stat file.  It's a patch off the 2.4.15-pre1 proc.txt, but it
 > > worked fine patching it into 2.4.15-pre4 kernel.  Between which I
 > > don't actually think proc.txt has changed.
 > > 
 > > 	   Sven
 > > 
 > > [snip]
 > 
 > >  Summary
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > Please read the FAQ at  http://www.tux.org/lkml/
 > > 
 > > 
 > 
 > Hey I wrote the last update to this file about exactly one year ago, and 
 > I wrote it for the same reasons as you.
 > 
 > I needed some info about some files and fields in the proc tree, and the 
 > responses was 1) read proc.txt (seriously out of date) and 2) look at 
 > the source Luke.
 > 
 > So I also got tired of seeking & greping around the code and wrote a 
 > small update, nice to see someone updated it again.
 > 
 > P.D. It should be updated by the people who updates the interface, at 
 > least minimally, the name and meaning of the fields or where to look.
 > 
 > -- 
 > Jorge Nerin
 > <comandante@zaralinux.com>
 > 
