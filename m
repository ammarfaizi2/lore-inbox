Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRCVH6W>; Thu, 22 Mar 2001 02:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131904AbRCVH6M>; Thu, 22 Mar 2001 02:58:12 -0500
Received: from www.wen-online.de ([212.223.88.39]:34316 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131899AbRCVH6D>;
	Thu, 22 Mar 2001 02:58:03 -0500
Date: Thu, 22 Mar 2001 08:57:18 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.31.0103212217320.10817-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0103220855370.1539-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Linus Torvalds wrote:

> Ho humm. Does the appended patch fix it for you? Looks obvious enough, but

Confirmed.

	-Mike

