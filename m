Return-Path: <linux-kernel-owner+w=401wt.eu-S932771AbWLNPIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbWLNPIB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWLNPIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:08:01 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:60384 "EHLO
	mailhub.fokus.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932771AbWLNPIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:08:00 -0500
Date: Thu, 14 Dec 2006 16:06:52 +0100
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: jens.axboe@oracle.com
Cc: teunis@alphatrade.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 kernel series, SATA, wodim (cd recording), synaptics
  update,
Message-ID: <4581688c.HZdDIJzhKiuGBiO9%Joerg.Schilling@fokus.fraunhofer.de>
References: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
 <20061214140315.GB5010@kernel.dk>
In-Reply-To: <20061214140315.GB5010@kernel.dk>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:

> On Thu, Dec 14 2006, Joerg Schilling wrote:
> > >CD recording : recorder no longer detected by "wodim" software set in
> > >2.6.19.   I suspect it's a bug in the software...  but don't know where
> > >to look for changes.   2.6.19-rc5 worked.
> > >hardware: IDE MATSHITADVD-RAM UJ-820S
> > >(2.6.19-git6 also fails with external LiteON USB DVD burner)
>
> It was an intermittent unlucky bug between 2.6.19 and 2.6.20-rc1, it got
> fixed the other day. Update your kernel, and it'll work again.

OK, thank you for the info.

> > Do not use cdrecord derivates but the original as derivates may have bugs
> > that are not present in the original.
>
> And vice versa :-)

I know of no problem that is only in the original, but there are dozens of 
problems that have been fixed since the derivate has been frozen in May.

If you know of any problem in the original, feel fre to report it!

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
