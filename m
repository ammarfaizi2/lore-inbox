Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTFMJFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTFMJFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:05:33 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:20104 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S265281AbTFMJFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:05:32 -0400
Date: Fri, 13 Jun 2003 11:19:11 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Clemens Schwaighofer <cs@tequila.co.jp>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uptime wrong in 2.5.70
In-Reply-To: <3EE9903E.2040101@tequila.co.jp>
Message-ID: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
> with my uptime.
>
> gentoo root # uptime
>  22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00

Doesn't ring any bell yet. Can you cat /proc/uptime and /proc/stat output?
Is this immediately after booting? Reproducable?

Tim

