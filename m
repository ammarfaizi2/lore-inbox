Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSD3KpU>; Tue, 30 Apr 2002 06:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSD3KpT>; Tue, 30 Apr 2002 06:45:19 -0400
Received: from krynn.axis.se ([193.13.178.10]:51865 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S311701AbSD3KpS>;
	Tue, 30 Apr 2002 06:45:18 -0400
From: johan.adolfsson@axis.com
Message-ID: <00e901c1f02f$1a783820$bdb270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <quinlan@transmeta.com>, "Johan Adolfsson" <johan.adolfsson@axis.com>
Cc: <quinlan@transmeta.com>, <marcelo@conectiva.com.br>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204291326230.25892-100000@ado-2.axis.se> <15565.55114.422518.394576@transmeta.com>
Subject: Re: [PATCH] cramfs 1/6 - timestamp in includes
Date: Tue, 30 Apr 2002 12:09:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Daniel Quinlan" <quinlan@transmeta.com>
> These first three look good.  

Any particular doughts about the metafile stuff or do you just need
some more time to look at it?
Unless I screwed something subtle up in the merge, it has been 
working fine for us in production use for more then a year or so, 
we have the same thing in our mkfs.jffs, genromfs and a patch for 
mkfs.jffs2 as well I think.

> I made a few minor changes and merged it
> with the big-endian patch, so I'll send you my current version before
> sending it onwards to Marcelo and Linus.
>
> The big-endian patch was waiting for 2.4.19 to be released, but maybe I
> should just submit it if 2.4.19 is going to be a while.  Also, all of
> the big-endian changes are checked into the CVS tree now.

Great, I say: "go for it!" and try to get it in before 2.4.19,
it's rather small and clean.

> Dan

/Johan
 

