Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132421AbRDJMk4>; Tue, 10 Apr 2001 08:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDJMei>; Tue, 10 Apr 2001 08:34:38 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:61629 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S131654AbRDJMd6>; Tue, 10 Apr 2001 08:33:58 -0400
Date: Tue, 10 Apr 2001 08:33:40 -0400
From: lists@sapience.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx and newer kernels
Message-ID: <20010410083340.A16601@sapience.com>
In-Reply-To: <20010408001132.A28840@sapience.com> <200104092119.f39LJts17813@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104092119.f39LJts17813@aslan.scsiguy.com>; from gibbs@scsiguy.com on Mon, Apr 09, 2001 at 03:19:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Justin:

Ya think very buggy? I checked seagate web page and 
unfortunately was unable to find any firmware updates
for the barracuda drives.

Curious tho that this has worked flawlessly for well over a 
year with all prior version of linux and win2000 as well.  
Also a few other folks seem to have similar problems with 
newer kernels. 

Do the newer drivers put a bigger demand on the drives that 
might start to uncover the problems previously not seen? 

I did find newer firmware for the adaptec 2940u2w card 
tho so perhaps I should upgrade that?

I will try turning off write cache - kernel config option right?

Will report back.

Thanks for your help - it sure would be nice to be able to
run with the newer kernels again!

Regards,


Gene/

On Mon, Apr 09, 2001 at 03:19:55PM -0600, Justin T. Gibbs wrote:
> >Apr  7 19:56:13 snap kernel:   Vendor: SEAGATE   Model: ST318275LW        Rev:
> > 0001
> 
> I seem to recall this being a very buggy firmware version.  You should
> check with Seagate to see if they have something new.  If this is the
> firmware I'm thinking of, the driver should perform correctly if you
> disable write caching.  You can do this via the SCSI-Select menu for
> the controller.
> 
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
