Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHTMvh>; Tue, 20 Aug 2002 08:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSHTMvg>; Tue, 20 Aug 2002 08:51:36 -0400
Received: from pD9E23620.dip.t-dialin.net ([217.226.54.32]:14982 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317023AbSHTMvf>; Tue, 20 Aug 2002 08:51:35 -0400
Date: Tue, 20 Aug 2002 06:55:35 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [BUG] 2.5.30 swaps with no swap device mounted!!
In-Reply-To: <20020819105520.GK18350@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0208200655040.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Aug 2002, William Lee Irwin III wrote:
> Due to the natural slab shootdown laziness issues, I turned off swap.
> The kernel reported that it had successfully unmounted the swap device,
> and for several days ran without it. Tonight, it went 91MB into swap
> on the supposedly unmounted swap device!

It might be interesting to see what happens if you unplug the swap device 
after umounting.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

