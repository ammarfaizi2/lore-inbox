Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbRF1PqI>; Thu, 28 Jun 2001 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbRF1Pps>; Thu, 28 Jun 2001 11:45:48 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:2432 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S265995AbRF1Ppq>;
	Thu, 28 Jun 2001 11:45:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.6-pre6 cs46xx build error with CONFIG_SOUND_FUSION=m
Date: Thu, 28 Jun 2001 09:42:55 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, fdavis@andrew.cmu.edu
In-Reply-To: <E15FdnX-00076n-00@the-village.bc.nu>
In-Reply-To: <E15FdnX-00076n-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01062809425500.01131@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 09:33, Alan Cox wrote:
> > With CONFIG_SOUND_FUSION=m, I get the following error for 2.4.6-pre6
> > during make modules:
> >
> > I've got a number of older 2.4.[3,4,5] kernels, so I'll go back and try
> > to figure out when the change occured, but this is the first time I've
> > seen this particular build error.
>
> I've fixed the build bug in ac20.. just uploading now

At the suggestion of Frank Davis, I tried 2.4.5-ac19, and it built just fine for me
with CONFIG_SOUND_FUSION=m, and sound is also working with 2.4.5-ac19.

I don't see -ac20 yet, but will try it later today with CONFIG_SOUND_FUSION=m
and CONFIG_SOUND_FUSION=y.

Thanks,
Steven
