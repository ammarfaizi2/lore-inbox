Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277010AbRJCWEL>; Wed, 3 Oct 2001 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277008AbRJCWEB>; Wed, 3 Oct 2001 18:04:01 -0400
Received: from cs.columbia.edu ([128.59.16.20]:11696 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S277011AbRJCWDr>;
	Wed, 3 Oct 2001 18:03:47 -0400
Date: Wed, 3 Oct 2001 18:04:16 -0400
Message-Id: <200110032204.f93M4GV09007@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jdthood@home.dhs.org (Thomas Hood)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011003214609.DCB3F10E5@thanatos.toad.net>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001 17:46:09 -0400 (EDT), Thomas Hood <jdthood@home.dhs.org> wrote:

> What happens if you read from the numerically named files in /proc/bus/pnp?
> (Do sync;sync;sync before trying this.)

Nothing happens on the inspiron 5000 (I don't have the other one handy 
right now). I tried reading from all the files in that directory,
including those in the boot subdirectory, and it worked fine. lspnp 
also works and its output makes sense.

This is with 2.4.10-ac4, obviously, since 2.4.9-ac16 doesn't boot.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
