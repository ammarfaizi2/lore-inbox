Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJQEHF>; Wed, 17 Oct 2001 00:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbRJQEGp>; Wed, 17 Oct 2001 00:06:45 -0400
Received: from airtrout.tregar.com ([209.73.238.93]:24582 "HELO
	airtrout.tregar.com") by vger.kernel.org with SMTP
	id <S274603AbRJQEGf>; Wed, 17 Oct 2001 00:06:35 -0400
Date: Tue, 16 Oct 2001 23:55:40 -0400 (EDT)
From: Sam Tregar <sam@tregar.com>
X-X-Sender: <sam@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Update: APM suspend broken in 2.4.12
In-Reply-To: <Pine.LNX.4.33.0110152349350.10534-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0110162353430.25850-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Sam Tregar wrote:

> Hello all.  I just upgraded from 2.4.9 to 2.4.12.  I chose the same kernel
> APM options in 2.4.12 as I had in 2.4.9 - CONFIG_APM, CONFIG_APM_DO_ENABLE
> and CONFIG_APM_CPU_IDLE.  When I try to suspend using my laptop's suspend
> key nothing happens.  Trying "apm --suspend" results in "apm: Resource
> temporarily unavailable".  Standby still works.

After applying the 2.4.12-ac3 patch suspend works again.  Thank you Alan!

-sam

