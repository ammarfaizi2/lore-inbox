Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTBTMnn>; Thu, 20 Feb 2003 07:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBTMl5>; Thu, 20 Feb 2003 07:41:57 -0500
Received: from coral.ocn.ne.jp ([211.6.83.180]:47610 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP
	id <S265543AbTBTMlZ>; Thu, 20 Feb 2003 07:41:25 -0500
Date: Thu, 20 Feb 2003 21:51:28 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: song.zhao@nuix.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Message-Id: <20030220215128.0c77c98e.bharada@coral.ocn.ne.jp>
In-Reply-To: <200302202201.15977.song.zhao@nuix.com.au>
References: <200302202034.28676.song.zhao@nuix.com.au>
	<20030220102115.GA5217@middle.of.nowhere>
	<200302202201.15977.song.zhao@nuix.com.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003 22:01:15 -0500
Song Zhao <song.zhao@nuix.com.au> wrote:

> > > Also, this board can't even boot with 8x 1GB memory modules plugged in
> > > (8 DIMM slots in total). This is a relative new board and I can't find
> > > anything relevant on the net.
> >
> > "can't boot" as in crashes halfway during linux or doesn't even start
> > lilo?
> 
> It doesn't even start Lilo, it hangs after it checks memory, 3ware card and 
> network card. 

In that case, it has nothing to do with Linux... Have you checked to see if
there's any BIOS updates?
