Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278457AbRJOW3c>; Mon, 15 Oct 2001 18:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278458AbRJOW3W>; Mon, 15 Oct 2001 18:29:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11259
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278457AbRJOW3R>; Mon, 15 Oct 2001 18:29:17 -0400
Date: Mon, 15 Oct 2001 15:29:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: Slo Mo Snail <slomo@beermail.no-ip.com>,
        "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How many versions of VM are there?
Message-ID: <20011015152942.D4482@mikef-linux.matchmail.com>
Mail-Followup-To: Tim Moore <timothymoore@bigfoot.com>,
	Slo Mo Snail <slomo@beermail.no-ip.com>,
	"M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110151105400.22170-100000@shell1.aracnet.com> <E15tEoY-0000dt-00@beermail.no-ip.com> <20011015141520.A4482@mikef-linux.matchmail.com> <3BCB6230.905E5C21@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BCB6230.905E5C21@bigfoot.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 03:24:48PM -0700, Tim Moore wrote:
> Mike Fedyk wrote:
> > 
> > On Mon, Oct 15, 2001 at 10:58:22PM +0200, Slo Mo Snail wrote:
> > > As far as I know there are 2 different version of VM:
> > > 2.2.x and 2.4.x-acyy: Rik von Riel's VM (but I'm not sure wether it's the
> > > same VM)
> > 
> > No.
> > 
> > It's not the same VM.  2.2 had a VM change from Andrea at about 2.2.17-18,
> > don't know about before...
> 
> 2.2.19pre2
> o       Drop the page aging for a moment to merge the
>         Andrea VM
> o       Merge Andrea's VM-global patch                  (Andrea
> Arcangeli)
> 

So 2.2 used page aging like 2.0 and 2.4 until 2.2.19pre2?
