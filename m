Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271776AbRHUSSA>; Tue, 21 Aug 2001 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271772AbRHUSRu>; Tue, 21 Aug 2001 14:17:50 -0400
Received: from ns.ithnet.com ([217.64.64.10]:41736 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271776AbRHUSRk>;
	Tue, 21 Aug 2001 14:17:40 -0400
Date: Tue, 21 Aug 2001 20:17:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010821201733.40fae5cf.skraw@ithnet.com>
In-Reply-To: <20010821174918Z16114-32383+718@humbolt.nl.linux.org>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com>
	<20010821142659Z16034-32384+269@humbolt.nl.linux.org>
	<20010821194140.43b46b10.skraw@ithnet.com>
	<20010821174918Z16114-32383+718@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001 19:55:49 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> Do you have highmem configged?  Try it with highmem off.

I did. Problem stays:

Aug 21 20:14:51 admin kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0).
Aug 21 20:14:51 admin last message repeated 146 times

Next idea?

Regards,
Stephan

