Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSJaRzx>; Thu, 31 Oct 2002 12:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSJaRzx>; Thu, 31 Oct 2002 12:55:53 -0500
Received: from bgp01387421bgs.brodwy01.nm.comcast.net ([68.35.130.254]:41600
	"EHLO www.tojabr.com") by vger.kernel.org with ESMTP
	id <S265266AbSJaRxv>; Thu, 31 Oct 2002 12:53:51 -0500
Date: Thu, 31 Oct 2002 11:00:16 -0700 (MST)
From: Tom Bradley <tojabr@tojabr.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <180577A42806D61189D30008C7E632E8793B26@boca213a.boca.ssc.siemens.com>
Message-ID: <Pine.LNX.4.44.0210311059250.3676-100000@www.tojabr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are just regular values. The UL tells the compiler to format the
number as an unsgned long.


On Thu, 31 Oct 2002, Bloch, Jack wrote:

> I am looking at some sample driver code which shows the usage of some
> unsigned integers 1UL, 2UL, 4UL, 16UL, 64UL, 128UL and 256UL.  I need to
> know what these are defined as. Please excuse my ignorance.
>
> Please CC me directly on any responses.
>
> Jack Bloch
> Siemens ICN
> phone                (561) 923-6550
> e-mail                jack.bloch@icn.siemens.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

