Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTGFOJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbTGFOJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 10:09:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16028 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265003AbTGFOJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 10:09:40 -0400
Date: Sun, 6 Jul 2003 11:21:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Confusion regarding the 2.4 prepatches and snapshots
In-Reply-To: <20030706131354.26756.qmail@web40002.mail.yahoo.com>
Message-ID: <Pine.LNX.4.55L.0307061112340.30050@freak.distro.conectiva>
References: <20030706131354.26756.qmail@web40002.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jul 2003, Brad Chapman wrote:

> Hi!
>
> I just noticed that hpa now has a link to a set of 2.4 BitKeeper
> snapshots, just below the link to the 2.4 prepatches. I would just like
> to know why snapshots _and_ prepatches are both being provided ATST,
> and what both sets of kernel patches contain respective to each other.

2.4-bk are daily snapshots generated automatically from "current" BK tree.

It makes the testing process easier for people who are using the latest
2.4 code.

-pre's are released by me.


Both of them are generated from the same tree, its just the timing that
changes.
