Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbRGRSYC>; Wed, 18 Jul 2001 14:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbRGRSXw>; Wed, 18 Jul 2001 14:23:52 -0400
Received: from www.wen-online.de ([212.223.88.39]:44804 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267515AbRGRSXd>;
	Wed, 18 Jul 2001 14:23:33 -0400
Date: Wed, 18 Jul 2001 20:22:14 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch
In-Reply-To: <Pine.LNX.4.33L.0107181016500.27454-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107182018360.380-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Rik van Riel wrote:

> On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
>
> > The following patch (against 2.4.6-ac2, already merged in 2.4.6-ac3) adds
> > specific perzone inactive/free shortage handling code.
>
> Marcelo, now that you have the nice VM statistics
> patch, do you have some numbers on how this patch
> affects the system, or is this patch based on
> guesswork ?  ;)

Have you read Dirk's logs or read the pertinent threads at all?

	-Mike

