Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291168AbSBGPOI>; Thu, 7 Feb 2002 10:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291167AbSBGPOA>; Thu, 7 Feb 2002 10:14:00 -0500
Received: from [195.163.186.27] ([195.163.186.27]:44251 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S291166AbSBGPNm>;
	Thu, 7 Feb 2002 10:13:42 -0500
Date: Thu, 7 Feb 2002 17:13:32 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Robin Farine <robin.farine@acn-group.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 freezes
Message-ID: <20020207171332.D20396@mea-ext.zmailer.org>
In-Reply-To: <1013089032.8112.6.camel@halftrack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013089032.8112.6.camel@halftrack>; from robin.farine@acn-group.ch on Thu, Feb 07, 2002 at 02:37:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 02:37:12PM +0100, Robin Farine wrote:
> Hi,
> 
> The mailing-list archive contains some reports of 2.4.17 freezes or
> crashes in the context of specific hardware configuration, such as
> SCSI+ATA and UDMA66 or RAID. In my office however, I had three PCs
> running 2.4.17 from the Debian woody distribution, all of them
> PentiumIII 82371AB PIIX4 chipset but otherwise without anything fancy.

  The freezing machines all have RAID-1 and fast CPUs and a lot
  (500-1000 MB) memory ?  .. and are SMP ?
... 
> Hope this can help tracking the problem down or at least save some time
> to people with a similar situation,

  I reported on this two months ago, and a month ago I figured out
  that non-SMP kernel works just fine (although the other CPU
  at my SMP machine now idles...)

  Since then I have had to move the machine into location where
  I can't poke at it daily, and thus I can't test the thing now.

> Robin

/Matti Aarnio
