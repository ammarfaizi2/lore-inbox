Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279741AbRJYKEH>; Thu, 25 Oct 2001 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279742AbRJYKD6>; Thu, 25 Oct 2001 06:03:58 -0400
Received: from proxy.povodiodry.cz ([212.47.5.214]:29685 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S279741AbRJYKDj>;
	Thu, 25 Oct 2001 06:03:39 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 25 Oct 2001 12:04:12 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
Message-ID: <20011025120412.A7317@pc11.op.pod.cz>
In-Reply-To: <E15wQe6-0001wr-00@the-village.bc.nu> <Pine.LNX.4.33.0110241226020.5558-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110241226020.5558-100000@viper.haque.net>; from mhaque@haque.net on Wed, Oct 24, 2001 at 12:28:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The latter seems to be the case because Vita Samel (hope I got this right)
> > > just reported that "Booting into 2.4.10-ac10" fixed the problem. Perhaps
> > > it once was fixed and later defixed?
> >
> > Sounds like it. I'll have a look some point next week to see if I can see
> > what is up
> 
> I'm able fdisk/mke2fs with 2.4.13-pre6 without the error so long as I
> don't touch the device with hdparm.

	I have SCSI only system. My problems were with mke2fs >2GiB, but no
problems with fdisk (tried to fdisk/mke2fs my shiny new 40GiB Seagate SCSI
disk).

	Vita Samel
  
