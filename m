Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSFZU6P>; Wed, 26 Jun 2002 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSFZU6O>; Wed, 26 Jun 2002 16:58:14 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:9858 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id <S316827AbSFZU6N>;
	Wed, 26 Jun 2002 16:58:13 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: Bongani <bonganilinux@mweb.co.za>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020626204721.GK22961@holomorphy.com>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> 
	<20020626204721.GK22961@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7-1mdk 
Date: 26 Jun 2002 23:00:08 +0200
Message-Id: <1025125214.1911.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC the preemptive patch is now part of -ac

On Wed, 2002-06-26 at 22:47, William Lee Irwin III wrote:
> On Sat, Jun 22, 2002 at 10:13:52PM -0300, Alexandre Pereira Nunes wrote:
> > Hi, I'm using kernel 2.4.19-pre10-ac2 and it just printed the pretty
> > message below. Other pertinent information follows.
> > CC: if needed, because I'm not in the list.
> > Cheers,
> > Alexandre
> >  <3>X[3924] exited with preempt_count 1
> 
> Would you mind showing us the patch you used to merge preempt into -ac?
> 
> 
> Thanks,
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


