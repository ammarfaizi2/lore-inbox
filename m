Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRHAW6u>; Wed, 1 Aug 2001 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHAW6k>; Wed, 1 Aug 2001 18:58:40 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:20656 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S267474AbRHAW62>;
	Wed, 1 Aug 2001 18:58:28 -0400
Date: Thu, 2 Aug 2001 00:58:36 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.A41.4.31.0108020011350.28452-100000@pandora.inf.elte.hu>
Message-ID: <Pine.A41.4.31.0108020049360.61934-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

some notes again.
when kswapd was working, there was no hdd activity at all.
every interrup was handled after kswapd finished the 'work'.
after a reboot everything looks ok with the same modules, and
approximately the same load.

oh, I almost forgot, the swapfile is on a reiserfs partition.

Bye,
Szabi

