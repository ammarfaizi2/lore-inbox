Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFOW6q>; Sat, 15 Jun 2002 18:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSFOW6p>; Sat, 15 Jun 2002 18:58:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13584 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315721AbSFOW6m>;
	Sat, 15 Jun 2002 18:58:42 -0400
Date: Sat, 15 Jun 2002 23:58:42 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Steve Cole <coles@vip.kos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon 2000 XP MP nightmare
Message-ID: <20020615225842.GC610@gallifrey>
In-Reply-To: <003101c214bb$0275a720$0a00000a@kos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:56:09 up 11:42,  9 users,  load average: 2.00, 1.99, 1.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steve Cole (coles@vip.kos.net) wrote:
>  I'm not sure that what I'm experiencing is a kernel problem, but I thought
> I  would stick my foot in the door nonetheless, since I have no real
> indication of what is going on.

Hi Steve,

> I have a dual Athlon 2000+ XP MP system.  It's crashing very frequently and
> looks to be getting worse.  It seems to crash less with 2.4.19pre10-ac2
> which supports the 760 bus and 744x IDE controller, but with something that
> is as intermittent as this, who can tell?

Can I clarify something - are the processors XP's or MP's ?  If they are
XP's well then that isn't a supported operation and might well not work
relliably.

>  I get EIP errors and Null pointer exception errors during full kernel
> panics.  I've had a lot of file system corruption in ReiserFS originally and
> now in EXT2, both fixable though Reiser seemed worse.  Uptime is measured in
> hours - usually 12 or more, sometimes two or three.

Have you tried running this single processor? Is it reliable?

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
