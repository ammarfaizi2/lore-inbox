Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTLJRs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLJRs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:48:57 -0500
Received: from cibs9.sns.it ([192.167.206.29]:40196 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263795AbTLJRsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:48:54 -0500
Date: Wed, 10 Dec 2003 18:48:47 +0100 (CET)
From: venom@sns.it
To: Joe Thornber <thornber@sistina.com>
cc: Paul Jakma <paul@clubi.ie>, Jens Axboe <axboe@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <20031210174418.GF476@reti>
Message-ID: <Pine.LNX.4.43.0312101846290.24503-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Joe Thornber wrote:

>
> The LVM1 driver was removed because dm covered the same functionality
> + lots more, and is more flexible.  The LVM2 tools still understand
> the LVM1 metadata format, so there is no problem about not being able
> to read data in 2.6.

So I was right. Well, if back compatibility works, this solves most of the
problem.

> The main reason for submitting dm to 2.4 was
> that there are a lot of people out there who want to use LVM2/EVMS
> tools with 2.4, and kept asking me to do it.  If this is against
> Marcelos current policy then so be it; I probably should have checked
> with him before spamming lkml with the submission.

This is a good point, but patches are available, so those people can stil use
it, am I wrong?

Luigi

