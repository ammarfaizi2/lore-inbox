Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRIPPYu>; Sun, 16 Sep 2001 11:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271826AbRIPPYl>; Sun, 16 Sep 2001 11:24:41 -0400
Received: from rdu26-57-156.nc.rr.com ([66.26.57.156]:11168 "EHLO
	gateway.house") by vger.kernel.org with ESMTP id <S271129AbRIPPYe>;
	Sun, 16 Sep 2001 11:24:34 -0400
Subject: Re: broken VM in 2.4.10-pre9
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Ricardo Galli <gallir@m3d.uib.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109161711430.30482-100000@m3d.uib.es>
In-Reply-To: <Pine.LNX.4.33.0109161711430.30482-100000@m3d.uib.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Sep 2001 11:23:54 -0400
Message-Id: <1000653836.2440.0.camel@gromit.house>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to tell the VM to prune its cache? Or a way to limit the
amount of cache it uses?



On 16 Sep 2001 17:19:43 +0200, Ricardo Galli wrote:
> > So whether Linux uses swap or not is a 100% meaningless indicator of
> > "goodness". The only thing that matters is how well the job gets done,
> > ie was it reasonably responsive, and did the big untars finish quickly..
> 
> I am running 2.4.9 on a PII with 448MB RAM. After listening a couple of
> hours MP3 from the /dev/cdrom and KDE started, more than 70MB went to
> swap, about 300 MB in cache and KDE takes about 15-20 seconds just for
> logging out and showing the greeting console.
> 
> Obviously, all apps went to disk to leave space for caching mp3 files that
> are read only once. Altough logging out is not a very often process...
> 
> Regards,
> 
> 
> --ricardo
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


