Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263483AbSJGV50>; Mon, 7 Oct 2002 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263484AbSJGV5Z>; Mon, 7 Oct 2002 17:57:25 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:26672 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263483AbSJGV5Y>;
	Mon, 7 Oct 2002 17:57:24 -0400
Date: Tue, 8 Oct 2002 00:03:02 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Martin Waitz <tali@admingilde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 orinoco_cs.c compile failure
Message-ID: <20021007220302.GE14953@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	Martin Waitz <tali@admingilde.org>, linux-kernel@vger.kernel.org
References: <20021007210817.GD14953@wiggy.net> <20021007213815.GA1495@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007213815.GA1495@admingilde.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Martin Waitz wrote:
> adding workqueue isn't even needed, just remove tqueue.h

That was supposed to be the second patch, but 2.5.41 does not work on
my laptop at all so I didn't get around to that.

Wichert.

-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org                    http://www.wiggy.net/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
