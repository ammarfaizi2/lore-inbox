Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282190AbRLHQgx>; Sat, 8 Dec 2001 11:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282212AbRLHQgn>; Sat, 8 Dec 2001 11:36:43 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45033 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282190AbRLHQg2>; Sat, 8 Dec 2001 11:36:28 -0500
Date: Sat, 8 Dec 2001 11:36:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Would the father of init_mem_lth please stand up
Message-ID: <20011208113619.B7913@devserv.devel.redhat.com>
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com> <E16CfK5-000135-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16CfK5-000135-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 08, 2001 at 11:07:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No doubt, the existing code was bad. I fixed it somewhat for 2.4,
> > and am feeding it to Marcelo. I can forward-port that to 2.5
> > if anyone is interested.
> 
> Did you clean it up as far as making the disks an array of pointers not
> of objects ?
> 
> Alan

I was going to do it, but have not done yet.

BTW, it was pointed out that my analyzis of the init_mem_lth
was completely wrong - there is no bug that I thought is there.
So I better be careful with 2.4 changes.

-- Pete
