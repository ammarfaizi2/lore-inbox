Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSBRX3p>; Mon, 18 Feb 2002 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSBRX3i>; Mon, 18 Feb 2002 18:29:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10918 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288946AbSBRX3X>;
	Mon, 18 Feb 2002 18:29:23 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Feb 2002 23:29:17 GMT
Message-Id: <UTC200202182329.XAA03046.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, phillips@bonn-fries.net, torvalds@transmeta.com
Subject: Re: [PATCH] size-in-bytes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is ugly, one finds a lot of shifting left and right, as in
>>      limit = (size << BLOCK_SIZE_BITS) >> sector_bits;

> We want to stay with the shift counts.

You misunderstand.
I meant what I said in a very literal way, not as some kind
of colloquial expression.
And "left and right" has been replaced by "right".

Andries
