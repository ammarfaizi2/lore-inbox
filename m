Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130082AbRB1ILh>; Wed, 28 Feb 2001 03:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130096AbRB1IL1>; Wed, 28 Feb 2001 03:11:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:54021 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130082AbRB1ILS>;
	Wed, 28 Feb 2001 03:11:18 -0500
Date: Wed, 28 Feb 2001 09:11:04 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102280556040.972-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0102280908480.1266-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Have you tried to use SWAP_SHIFT as 4 instead of 5 on a stock 2.4.2-ac5 to
> > see if the system still swaps out too much?
>
> Not yet, but will do.

Didn't help.  (It actually reduced throughput a little)

	-Mike

