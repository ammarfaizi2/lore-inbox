Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbSJVO4P>; Tue, 22 Oct 2002 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSJVO4P>; Tue, 22 Oct 2002 10:56:15 -0400
Received: from rakshak.ishoni.co.in ([164.164.83.140]:9660 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S263966AbSJVO4O>; Tue, 22 Oct 2002 10:56:14 -0400
Subject: Re: running 2.4.2 kernel under 4MB Ram
From: Amol Kumar Lad <amolk@ishoni.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <1035281203.31873.34.camel@irongate.swansea.linux.org.uk>
References: <1035281203.31873.34.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Oct 2002 20:31:43 -0400
Message-Id: <1035333109.2200.2.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It means that I _cannot_ run 2.4.2 on a 4MB box. 
Actually my embedded system already has 2.4.2 running on a 16Mb. I was
looking for a way to run it in 4Mb. 
So Is upgrade to 2.4.19 the only option ??

-- Amol


On Tue, 2002-10-22 at 06:06, Alan Cox wrote:
> On Tue, 2002-10-22 at 19:54, Amol Kumar Lad wrote:
> > Hi,
> >  I want to run 2.4.2 kernel on my embedded system that has only 4 Mb
> > SDRAM . Is it possible ?? Is there any constraint for the minimum
> SDRAM
> > requirement for linux 2.4.2
> 
> You want to run something a lot newer than 2.4.2. 2.4.19 will run on a
> 4Mb box, and with Rik's rmap vm seems to be run better than 2.2. That
> will depend on the workload.


