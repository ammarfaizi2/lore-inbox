Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbRGKWrO>; Wed, 11 Jul 2001 18:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266862AbRGKWrE>; Wed, 11 Jul 2001 18:47:04 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:41614 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S266859AbRGKWqy>; Wed, 11 Jul 2001 18:46:54 -0400
Date: Wed, 11 Jul 2001 15:46:03 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: Paul Jakma <paul@clubi.ie>
cc: Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>
Message-ID: <Pine.GSO.4.10.10107111545130.14769-100000@clifton-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the future when Linux is more heavily used at the enterprise level
there will likely be upgrade/revert modules to allow such a transition to
take place.

			-Kip

On Wed, 11 Jul 2001, Paul Jakma wrote:

> On Wed, 11 Jul 2001, Helge Hafting wrote:
> 
> > That seems completely out of question.  The structures a 2.4.7
> > kernel understands might be insufficient to express the setup
> > a future 2.6.9 kernel is using to do its stuff better.
> 
> however, it might be handy if say you needed to upgrade a stable
> kernel due to a bug fix or security update.
> 
> no?
> 
> regards,
> -- 
> Paul Jakma	paul@clubi.ie	paul@jakma.org
> PGP5 key: http://www.clubi.ie/jakma/publickey.txt
> -------------------------------------------
> Fortune:
> I found Rome a city of bricks and left it a city of marble.
> 		-- Augustus Caesar
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

