Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278463AbRJOWYw>; Mon, 15 Oct 2001 18:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278458AbRJOWYd>; Mon, 15 Oct 2001 18:24:33 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:53139 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S278457AbRJOWYT>; Mon, 15 Oct 2001 18:24:19 -0400
Message-ID: <3BCB6230.905E5C21@bigfoot.com>
Date: Mon, 15 Oct 2001 15:24:48 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Slo Mo Snail <slomo@beermail.no-ip.com>,
        "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How many versions of VM are there?
In-Reply-To: <Pine.LNX.4.33.0110151105400.22170-100000@shell1.aracnet.com> <E15tEoY-0000dt-00@beermail.no-ip.com> <20011015141520.A4482@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Mon, Oct 15, 2001 at 10:58:22PM +0200, Slo Mo Snail wrote:
> > As far as I know there are 2 different version of VM:
> > 2.2.x and 2.4.x-acyy: Rik von Riel's VM (but I'm not sure wether it's the
> > same VM)
> 
> No.
> 
> It's not the same VM.  2.2 had a VM change from Andrea at about 2.2.17-18,
> don't know about before...

2.2.19pre2
o       Drop the page aging for a moment to merge the
        Andrea VM
o       Merge Andrea's VM-global patch                  (Andrea
Arcangeli)

rgds,
tim.
--
