Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262781AbTCVOaT>; Sat, 22 Mar 2003 09:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbTCVOaT>; Sat, 22 Mar 2003 09:30:19 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:27108 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262781AbTCVOaS>; Sat, 22 Mar 2003 09:30:18 -0500
Date: Sat, 22 Mar 2003 09:41:09 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about hdparm & dma.
Message-ID: <20030322144109.GA1389@Master.Wizards>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E7C4E8E.9030704@lucidpixels.com> <1048345010.8912.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048345010.8912.7.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 02:56:51PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 11:52, Justin Piszcz wrote:
> > My question is, how is it possible to get > 33MB/s in only UDMA Mode 2 
> > (the linux driver only supports up to UDMA2).
> 
> You can overclock things if you have the setup wrong.
> 
> > So basically I am wondering if udma mode 5 will be supported for SIS 
> > chipsets.
> 
> I'm wondering if SiS are ever going to provide useful documentation.
> SiS won't deal with individuals only companies which complicates matters
> 

Well, if you're not getting good docs from SiS I commend you on your abilities.
My P4S533 (SiS645DX chipset) is doing decently well with a Maxtor ATA/133 100G
drive. It's only a 5400rpm drive and nearly matches the 120G WD ATA/100 7200rpm
in my Dell for hdparm speeds. I was a little disappointed in the speed 
comparisons till I saw that you're doing this blind.

Thanks.

-- 
Murray J. Root

