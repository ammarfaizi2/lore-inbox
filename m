Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTDUKpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbTDUKpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:45:55 -0400
Received: from [12.47.58.203] ([12.47.58.203]:38207 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263810AbTDUKpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:45:54 -0400
Date: Mon, 21 Apr 2003 03:58:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [TRIDENT] teach trident_interrupt() about irqreturn_t
Message-Id: <20030421035818.71283264.akpm@digeo.com>
In-Reply-To: <20030421100712.GA2188@actcom.co.il>
References: <20030421100712.GA2188@actcom.co.il>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2003 10:57:52.0442 (UTC) FILETIME=[DB0469A0:01C307F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> Hi Linus, 
> 
> This patch updates trident_interrupt() to return
> IRQ_HANDLED

I've just done the whole kernel apart from a few scsi drivers (I think).

Sit tight for a day...

