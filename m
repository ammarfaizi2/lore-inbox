Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbSJDNSs>; Fri, 4 Oct 2002 09:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJDNSs>; Fri, 4 Oct 2002 09:18:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261736AbSJDNSq>;
	Fri, 4 Oct 2002 09:18:46 -0400
Date: Fri, 4 Oct 2002 14:24:19 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
Message-ID: <20021004132419.GF710@gallifrey>
References: <Pine.LNX.3.96.1021004041421.5688A-100000@Maggie.Linux-Consulting.com> <1033735943.31839.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033735943.31839.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 14:18:42 up 2 days, 15:45,  1 user,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> 
> The problem with disks is you still have to archive them somewhere, and
> they are bulky. I also dont know what studies are available on the
> degradation of stored disk media over time. 

Not sure about that; DLT tapes are pretty bulky themselves; I think the
difference between say a set of 4 DLT tapes and a single Maxtor 320 in
caddy would be minimal. As for stored media, I think Maxtor are quoting
1M hours MTTF - (I hate to think how you measure such a figure) - for
the 320G, and that is probably longer than I'd trust either the tape or
the drive to survive.

> Capacity is not a problem, 3ware do a 12 channel sata card, with maxtor
> drives that comes in at 320x12 = 3.5Tb

Well to me there are two questions:
  1) Price with caddy/drive - especially when you need to have
	multiple backup sets.

	2) Linux serial/ata working reliably with hot swapping.

If both those came out on the right side then I'd happily swap to discs.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
