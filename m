Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281897AbRKZPyE>; Mon, 26 Nov 2001 10:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281896AbRKZPxy>; Mon, 26 Nov 2001 10:53:54 -0500
Received: from 24-240-35-67.hsacorp.net ([24.240.35.67]:2944 "HELO
	majere.epithna.com") by vger.kernel.org with SMTP
	id <S281897AbRKZPxp>; Mon, 26 Nov 2001 10:53:45 -0500
Date: Mon, 26 Nov 2001 10:53:41 -0500 (EST)
From: <listmail@majere.epithna.com>
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Mixing Patches: pre-emptive + xfs
In-Reply-To: <F128989C2E99D4119C110002A507409801C53035@topper.hrow.ndsuk.com>
Message-ID: <Pine.LNX.4.33.0111261050140.5940-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may need to do some custom work to get them to play well together,
this is true of any double or Triple patched kernel.  I frequently patch
with 2 sometimes 3 different patches (one less now that ext3 is in the
kernel!) and find that it sometimes takes a little looking around in the
diffs to make sure that the patches do not conflict.  But it can be done.
I have not looked at these specific patches however.

Bill Dunn

On Mon, 26 Nov 2001, Elgar, Jeremy wrote:

> Hello
> Just wondering if anyone has try using these two patches together (or is
> this a really bad idea)
>
> I'm thinking of adding the pre-emptive patch to my laptop and desk top.
>
> Cheers
>
> Jeremy
>
> (BTW both are 2.4.14)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

