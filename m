Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbSJDRKX>; Fri, 4 Oct 2002 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSJDRKX>; Fri, 4 Oct 2002 13:10:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262599AbSJDRKV>;
	Fri, 4 Oct 2002 13:10:21 -0400
Date: Fri, 4 Oct 2002 18:15:55 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID backup
Message-ID: <20021004171555.GH710@gallifrey>
References: <Pine.LNX.3.96.1021004041421.5688A-100000@Maggie.Linux-Consulting.com> <1033735943.31839.12.camel@irongate.swansea.linux.org.uk> <20021004132419.GF710@gallifrey> <20021004150752.B16727@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004150752.B16727@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 18:11:26 up 2 days, 19:38,  1 user,  load average: 0.00, 0.12, 0.39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk@arm.linux.org.uk) wrote:

> However, drive in caddy or no caddy, the accidental drop test would
> probably be more favourable to the DLT tape surviving over the drive.
> Physical accidents do happen.

While I guess a good caddy might put a lump of rubber in to help. But
there again I'm not sure if I have that much confidence in the DLT tapes
either; the instructions in the insert for HP DLT tapes tell you to
rattle them and listen to hear if you can hear anything loose
before putting them into your drive!

Anyway, from the side of data integrity the drop test doesn't worry me -
for critical data I have a lot more than one backup; and users perform
an important part of the backup test system by regularly deleting files
to be restored.

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
