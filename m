Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310647AbSCPUuw>; Sat, 16 Mar 2002 15:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310681AbSCPUul>; Sat, 16 Mar 2002 15:50:41 -0500
Received: from ns.suse.de ([213.95.15.193]:55818 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310647AbSCPUuY>;
	Sat, 16 Mar 2002 15:50:24 -0500
Date: Sat, 16 Mar 2002 21:50:23 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: S W <egberts@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
Message-ID: <20020316215023.D15296@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, S W <egberts@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020316204228.B15296@suse.de> <E16mLIY-00079l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16mLIY-00079l-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 09:01:06PM +0000, Alan Cox wrote:
 > >  > But I recalled Linux 2.2 having a bug fix for broken
 > >  > L2 cache in Cyrix II.
 > >  The cache itself isn't broken. Reporting of the size of it is.
 > He's talking about a different bug. Some early 6x86 processors had weird
 > problems with cache behaviour that would sometimes break stuff.

 Ah, my bad.  So much errata, so little memory..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
