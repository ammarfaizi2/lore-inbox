Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311247AbSDAJiE>; Mon, 1 Apr 2002 04:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSDAJho>; Mon, 1 Apr 2002 04:37:44 -0500
Received: from hera.cwi.nl ([192.16.191.8]:477 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S311239AbSDAJhe>;
	Mon, 1 Apr 2002 04:37:34 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 1 Apr 2002 09:37:31 GMT
Message-Id: <UTC200204010937.JAA474681.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, p_gortmaker@yahoo.com
Subject: Re: kbdbook.tmpl
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +  See also kbd_mode(1).

Thanks! Added.

> did you forsee putting these in another file,
> perhaps with the other vt ioctls?

Possibly. Describing all ioctl's is far too much work
for me to do alone, so my main aim was to provide a
good start and hope that others contribute more
until we have a complete set of docs.

> maybe we can avoid having N copies of the usual GPL boiler plate

I almost wrote "this is in the public domain",
maybe I should have, but ended taking the same copyright blurb
that all the other books also have. It may be convenient in
case someone ever wants to publish a printed version when
all fragments have the same copyright.

Andries

