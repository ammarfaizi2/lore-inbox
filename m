Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbRBGTLd>; Wed, 7 Feb 2001 14:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129500AbRBGTLX>; Wed, 7 Feb 2001 14:11:23 -0500
Received: from infoblox.com ([64.39.15.22]:50705 "HELO torpid.com")
	by vger.kernel.org with SMTP id <S129879AbRBGTLG>;
	Wed, 7 Feb 2001 14:11:06 -0500
Date: Wed, 7 Feb 2001 13:15:21 -0600 (CST)
From: Ivan Pulleyn <ivan@torpid.com>
To: Chris Mason <mason@suse.com>
cc: Vedran Rodic <vedran@renata.irb.hr>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <552640000.981571531@tiny>
Message-ID: <Pine.LNX.4.10.10102071311310.9686-100000@norway.torpid.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Chris Mason wrote:

> 
> 
> On Wednesday, February 07, 2001 07:41:25 PM +0100 Vedran Rodic
> <vedran@renata.irb.hr> wrote:
> 
> > 
> > So could some of this bugs also be present in 3.5.x version of reiserfs?
> > Will you be fixing them for that version?
> > 
> 
> This list of reiserfs bugs was all specific to the 3.6.x versions, and they
> don't appear with the 3.5.x code.  You will probably have problems if you
> compile 3.5.x reiserfs with an unpatched redhat gcc 2.96, though.  

Apologies if I'm mis-understanding (I don't follow the list too
closely), but the zeros-in-log-files thing happens to me a lot on
3.5.X. Is there some sort of debugging info I could offer to help
figure it out?

Ivan...

---------------------------------------------------------------------------
			     Ivan Pulleyn
		      4942 N. Winchester Ave. #3
			  Chicago, IL 60640

			   ivan@torpid.com
			    (847) 980-1400
---------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
