Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFSNZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFSNZz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 09:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFSNZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 09:25:55 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:45004 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261227AbVFSNZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 09:25:50 -0400
Date: Sun, 19 Jun 2005 09:25:41 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Rafael =?iso-8859-1?q?Rodr=EDguez?= <apt-drink@gulic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: codec_semaphore: semaphore is not ready
In-Reply-To: <200506191402.02287.apt-drink@gulic.org>
Message-ID: <Pine.LNX.4.58.0506190923500.915@localhost.localdomain>
References: <200506191402.02287.apt-drink@gulic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Jun 2005, Rafael Rodríguez wrote:

> Hi. Since I upgraded to 2.6.12, i get messages like
>
> codec_semaphore: semaphore is not ready [0x1][0x
> 301300]
> codec_write 1: semaphoreis not ready for register 0x54
>
> _randomly_ (meaning that in some boots it shows up, but in others doesn't) in
> some init scripts (for example, alsa).
>
> It's an HP pavilion zv5000 (amd64 laptop). Please tell me which more info may
> I supply to trace this. But I repeat, it's not _always_ reproducible.
>

Just to let you know that you are not alone, I get the same messages. I'm
too busy getting ready for a trip to Europe, I haven't had time to look
further into this, otherwise I would.  But I would like to let others know
that this isn't just happening to one person.

-- Steve
