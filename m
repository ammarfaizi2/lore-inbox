Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130530AbQLEMmr>; Tue, 5 Dec 2000 07:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbQLEMmd>; Tue, 5 Dec 2000 07:42:33 -0500
Received: from viva.uti.hu ([213.163.24.26]:61711 "HELO viva.uti.hu")
	by vger.kernel.org with SMTP id <S130530AbQLEMmY>;
	Tue, 5 Dec 2000 07:42:24 -0500
Date: Tue, 5 Dec 2000 13:11:48 +0100
From: Gábor Lénárt <lgb@viva.uti.hu>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any good reason why these is so much memory "reserved"?
Message-ID: <20001205131148.B19166@viva.uti.hu>
In-Reply-To: <200012051040.CAA03227@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012051040.CAA03227@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Dec 05, 2000 at 02:40:59AM -0800
X-Operating-System: viva Linux 2.2.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 02:40:59AM -0800, Adam J. Richter wrote:
> Gábor Lénárt writes:
> >On Tue, Dec 05, 2000 at 02:18:59AM -0800, Adam J. Richter wrote:
> >>       Recently, I have had occasion to build a system on a floppy
> >> for a 4MB machine that we use as a router.  In the past, the kernels
> >
> >I've played with this too. You can't use ramdisk easily on such a system.
> [snip]
> 
> 	We are using such a system and have been for years.
> If you'll reread my posting, you will see that it is about relatively
> recent changes to the kernel that apparently have broken this.

Yes, I know. My goal was only to show that newer kernels has got more
memory overhead but it was easy with older kernels so I only want to
say that you mentioned: it seems to be true ...

-- 
 ---[ Gábor Lénárt ]----[ Vivendi Telecom Hungary ]---[ lgb@supervisor.hu ]---
 U have 8 bit computer or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]--------> LGB <-------[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
