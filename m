Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311938AbSCOFbS>; Fri, 15 Mar 2002 00:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311937AbSCOFbL>; Fri, 15 Mar 2002 00:31:11 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:17169 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311934AbSCOFaz>;
	Fri, 15 Mar 2002 00:30:55 -0500
Date: Fri, 15 Mar 2002 13:35:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bjorn Wesen <bjorn.wesen@axis.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020315023509.GB1289@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Bjorn Wesen <bjorn.wesen@axis.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203141139400.26308-100000@godzilla.axis.se> <3C90802B.509@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C90802B.509@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 05:49:15AM -0500, Jeff Garzik wrote:
> Bjorn Wesen wrote:
> 
> >Just a datapoint:
> >
> >The orinico driver (already in the kernel) works fine with the DWL-650 
> >card. Tried it some days ago.. not a very big field trial but I inserted 
> >the card and I got an eth0 from it and it worked, so thats the way I like 
> >it :)
> 
> 
> Not "just" a datapoint, a useful one.  Thanks.

Sadly not everybody is having as much luck.  A lot of people are
reporting terribly throughput on Intersil cards like the DWL-650 and I
haven't managed to track the problem down yet.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

