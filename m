Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRA3D1X>; Mon, 29 Jan 2001 22:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbRA3D1O>; Mon, 29 Jan 2001 22:27:14 -0500
Received: from cs.columbia.edu ([128.59.16.20]:63947 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129274AbRA3D07>;
	Mon, 29 Jan 2001 22:26:59 -0500
Date: Mon, 29 Jan 2001 19:26:55 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jamal <hadi@cyberus.ca>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.GSO.4.30.0101292139170.29307-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101291924140.31713-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, jamal wrote:

> > 11.5kBps, quite consistently.
>
> This gige card is really sick. Are you sure? Please double check.

Umm.. the starfire chipset is 100Mbit only. So 11.5MBps (sorry, that was a
typo, it's mega not kilo) is really all I'd expect out of it.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
