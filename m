Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVC2UVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVC2UVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVC2UUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:20:49 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:62849 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261411AbVC2UTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:19:49 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Keystroke simulator
To: Mister Google <binary-nomad@hotmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 29 Mar 2005 21:25:50 +0200
References: <fa.i7mbmvh.16m8c19@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DGMLZ-0004Va-9F@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mister Google <binary-nomad@hotmail.com> wrote:

> Is there a way to simulate a keystroke to a program, ie. have a program send
> it something so that as far as it's concerned, say, the "P" key has been
> pressed?

Yes. That's what programs like telnetd do.

Look for man 4 pts.
