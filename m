Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFAIoL>; Fri, 1 Jun 2001 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbRFAIoA>; Fri, 1 Jun 2001 04:44:00 -0400
Received: from [208.48.139.185] ([208.48.139.185]:33411 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S263421AbRFAInt>; Fri, 1 Jun 2001 04:43:49 -0400
Date: Fri, 1 Jun 2001 01:43:43 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
Message-ID: <20010601014343.B18178@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E155bG5-0008AX-00@the-village.bc.nu> <Pine.LNX.4.10.10106011028150.6653-100000@webman.medikredit.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106011028150.6653-100000@webman.medikredit.co.za>; from kowalski@datrix.co.za on Fri, Jun 01, 2001 at 10:29:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know myself, (it sounds like other bigmem problems), but setting up a
2GB swap file is easy enough to test.  :-)

-Dave

On Fri, Jun 01, 2001 at 10:29:39AM +0200, Marcin Kowalski wrote:
> 
> I found this post of interest. I have 1.1 Gig of RAM but only 800mb of
> Swap as I expect NOT to use that much memory... Could this be the cause of
> the machines VERY erratic behaviour??? Kernel Panics, HUGE INOde and
> Dcache.... ??
> 
> On Thu, 31 May 2001 alan@lxorguk.ukuu.org.uk wrote:
> 
> > > My system has 128 Meg of Swap and RAM.
> > 
> > Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> > with 2.4.
> > 
> > Marcelo is working to change that but right now you are running something 
> > explicitly explained as not going to work as you want
