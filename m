Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRARAaq>; Wed, 17 Jan 2001 19:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRARAah>; Wed, 17 Jan 2001 19:30:37 -0500
Received: from fungus.teststation.com ([212.32.186.211]:49332 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129798AbRARAa2>; Wed, 17 Jan 2001 19:30:28 -0500
Date: Thu, 18 Jan 2001 01:30:11 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Rainer Mager <rmager@vgkk.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: Oops with 4GB memory setting in 2.4.0 stable
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGOECDCNAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.30.0101180122370.18642-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Rainer Mager wrote:

> Here is a newly parsed oops, this time using the /var/log/ksymoops method
> mentioned by Keith Owens. Does this look better?

Yes, and it sort of matches the other oops someone sent. Thanks.


I have a changed version now, based on the ncpfs directory cahce code.
But it doesn't work at all right now. (and that would be the "based on"
bit, the copy and paste bits haven't crashed yet :)

Assuming that all meetings have an end, and sometimes they don't seem to
have one, there may be something for you to try tomorrow.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
