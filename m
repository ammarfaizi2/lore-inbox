Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRDUT1Z>; Sat, 21 Apr 2001 15:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132848AbRDUT1M>; Sat, 21 Apr 2001 15:27:12 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:37101 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132846AbRDUT0t>; Sat, 21 Apr 2001 15:26:49 -0400
Date: Sat, 21 Apr 2001 21:26:46 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Dan Aloni <karrde@callisto.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@image.dk>
Subject: Re: cdrom driver dependency problem (and a workaround patch)
Message-ID: <20010421212645.W719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010421134412.O682@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.32.0104212032310.28315-100000@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.32.0104212032310.28315-100000@callisto.yi.org>; from karrde@callisto.yi.org on Sat, Apr 21, 2001 at 08:33:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 08:33:05PM +0300, Dan Aloni wrote:
> On Sat, 21 Apr 2001, Ingo Oeser wrote:
> > The link order is wrong. So why not changing the link order then?
> 
> I remember doing what the patch below does.
> It didn't help.
 
Hmm, maybe you had a typo?

> Did you try this patch?

Yes, just booted an SMP machine with 2.4.3-ac11 and this patch.

I booted remote, so it was some kind of dangerous, if it wouldn't
work ;-)

We also have SCSI enabled there. So it really works ;-)


Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
