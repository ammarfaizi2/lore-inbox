Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbRBGWtv>; Wed, 7 Feb 2001 17:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130165AbRBGWtl>; Wed, 7 Feb 2001 17:49:41 -0500
Received: from winds.org ([207.48.83.9]:61200 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129352AbRBGWt3>;
	Wed, 7 Feb 2001 17:49:29 -0500
Date: Wed, 7 Feb 2001 17:47:56 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Jason Ford <jason@heymax.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid 2.4.0 kernel
In-Reply-To: <PNEPLDDEADCDEBANKDDHEEGPCAAA.jason@heymax.com>
Message-ID: <Pine.LNX.4.21.0102071746060.7611-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Jason Ford wrote:

> I see in the archives of this mailing list that someone was working on the
> aacraid driver for the 2.4 kernel however that post was almost 2 months old.
> I know Alan Cox denied inclusion of the driver due to the poor nature it was
> written for the 2.2 tree. Every post that I have seen so far has just said
> that Adaptec is working on it. However, I am sure there are many people out
> there like myself that have to support this card in enviroments that would
> be benifical to upgrade to 2.4 kernel. I am not a part of this list however
> have been scouring through geocrawler.com archives of this list everyday for
> the last month hoping and waiting.

While it's totally unofficial, I have a patch for aacraid 1.0.6 for 2.4.1-ac5.
I have not tested it yet, but it compiles cleanly. I'd like to hear any results
(good or bad) you have on it.

You can find it at:

  ftp://ftp.winds.org/linux/patches/2.4.1/aacraid-2.4.1-1.0.6.patch

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
