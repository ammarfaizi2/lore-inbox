Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286999AbRL1UOK>; Fri, 28 Dec 2001 15:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286993AbRL1UOA>; Fri, 28 Dec 2001 15:14:00 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:58082 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S287003AbRL1UN5>;
	Fri, 28 Dec 2001 15:13:57 -0500
Date: Fri, 28 Dec 2001 21:13:48 +0100
From: Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>
To: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011228211348.A8720@upset.pdb.fsc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <20011228121228.GA9920@emma1.emma.line.org> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228163250.A31791@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011228163250.A31791@elektroni.ee.tut.fi>; from kaukasoi@elektroni.ee.tut.fi on Fri, Dec 28, 2001 at 04:32:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 04:32:50PM +0200, Petri Kaukasoina wrote:
> Hi, I used to make zImages, but for no specific reason. The last working
> version was 2.2.20pre3. 2.2.20pre5 gave Out of memory -- System halted. I
> reported it a few months ago:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.2/0363.html
> 
> This was the only change then that looks like it:
> 
> o       Add support for the 2.4 boot extensions to 2.2  (H Peter Anvin)
> -
Loading linux 2.2.20.......
Uncompressing Linux...


Out of memory


 -- System halted

Siemens/Nixdorf Mobile 710
Pentium MMX 166MHz, 128MB

Kernel 2.2.20 generated from perfectly running 2.2.19 with
make oldconfig; make dep; make zImage; ...

2.4.16 does not work too:
Loading linux 2.4.16........

[ black screen and than back in BIOS-boot ]

	Wolfgang
