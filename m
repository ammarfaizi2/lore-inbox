Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDGWHa>; Sat, 7 Apr 2001 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRDGWHU>; Sat, 7 Apr 2001 18:07:20 -0400
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:5504 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S132042AbRDGWHL>; Sat, 7 Apr 2001 18:07:11 -0400
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200104072207.PAA03796@cx518206-b.irvn1.occa.home.com>
Subject: Re: processes stuck in D state
To: linux4u@wanadoo.es (Pau Aliagas)
Date: Sat, 7 Apr 2001 15:07:11 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (lkml)
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.33.0104041744100.1585-100000@pau.intranet.ct> from "Pau Aliagas" at Apr 04, 2001 05:47:20 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pau Aliagas wrote:
> Since 2.2.4-ac28 and 2.4.3 I keep on getting processes in D state that I
> cannot kill, usually mozilla or nautilus which use a large amount of RAM.

I don't have time to help debug this, but I'm getting this too, with
2.4.3 final. The previous kernel I ran was 2.4.3-pre4, and it did not
have this problem.

In my case, it's usually mozilla (I'm seeing this with the daily
snapshots, but not with mozilla-0.8.1, at least not yet), but at least
once I saw it with freeamp (2.1rc5) too.

-Barry K. Nathan <barryn@pobox.com>
