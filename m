Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278347AbRJOVPM>; Mon, 15 Oct 2001 17:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278344AbRJOVPB>; Mon, 15 Oct 2001 17:15:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51440
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278313AbRJOVOy>; Mon, 15 Oct 2001 17:14:54 -0400
Date: Mon, 15 Oct 2001 14:15:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Slo Mo Snail <slomo@beermail.no-ip.com>
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: How many versions of VM are there?
Message-ID: <20011015141520.A4482@mikef-linux.matchmail.com>
Mail-Followup-To: Slo Mo Snail <slomo@beermail.no-ip.com>,
	"M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110151105400.22170-100000@shell1.aracnet.com> <E15tEoY-0000dt-00@beermail.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15tEoY-0000dt-00@beermail.no-ip.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 10:58:22PM +0200, Slo Mo Snail wrote:
> As far as I know there are 2 different version of VM:
> 2.2.x and 2.4.x-acyy: Rik von Riel's VM (but I'm not sure wether it's the
> same VM)

No.

It's not the same VM.  2.2 had a VM change from Andrea at about 2.2.17-18,
don't know about before...

> 2.4.x: Andrea's VM
> 

2.4.0-2.4.10pre10 = Rik's VM.

2.4.10pre11+ = Andrea's VM

2.4.12-ac has Rik's vm, and it looks like Alan will keep Rik's VM for a while.

> You find Documentation in
> Documentation/vm/*
> Documentation/sysctl/vm.txt
>

I think this is still out of date...  There's a patch at Rik's site.  Don't
know if it is accurate for Andrea's VM...

http://www.surriel.com/patches/

> but i think there's no Documentation of Andrea's VM yet
> 

True.  I don't know if Andrea is working on that yet...  It looks like he's
trying to iron out his new VM...

Mike
