Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290894AbSASBFt>; Fri, 18 Jan 2002 20:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290895AbSASBFj>; Fri, 18 Jan 2002 20:05:39 -0500
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:18910 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S290894AbSASBF2>;
	Fri, 18 Jan 2002 20:05:28 -0500
X-Sent: 19 Jan 2002 01:05:22 GMT
Message-ID: <3C48C64B.422003A1@bigfoot.com>
Date: Fri, 18 Jan 2002 17:05:15 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Tiensivu <mojomofo@mojomofo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133 & HPT 370 IDE disk corruption
In-Reply-To: <00c201c1a033$1cf46700$b71c64c2@viasys.com> <3C48BF64.FBF58C7C@bigfoot.com> <014501c1a083$e5c44650$58dc703f@bnscorp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:
> 
> > My BP6's [hpt366] had similar sustained I/O lockup issues, especially
> > when running a RAID stripe.  From the v1.01 BP6 manual:
> 
> Unfortunately, I suspect that is due to the older HPT drivers still in the
> current kernels (the HPT366 is a very broken beast by design, and from what
> I've gathered from others, is that Abit did poor job connecting it into the
> BP6)
> 
> Another reason for those lockups could be due to the noisy APIC bus on the
> BP6.
> 
> As much as I love my BP6, as an "ultimate dirty hack not approved by Intel"
> motherboard, it has its flaws.
> I'm just thankful it is still running. :)

Yes, the board you love to hate.  I also did the EC10 capacitor fix
which is why I still have no heart to retire/upgrade them.

--
