Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTGGWvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTGGWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:51:36 -0400
Received: from maila.telia.com ([194.22.194.231]:28643 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S264075AbTGGWvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:51:35 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030615001905.A27084@ucw.cz>
	<m2he6rv8i6.fsf@telia.com> <20030615142838.A3291@ucw.cz>
	<m2of0zqr4i.fsf@telia.com> <20030615192731.A6972@ucw.cz>
	<m2d6hbgdhw.fsf@telia.com>
	<pan.2003.06.23.16.30.42.431561@dungeon.inka.de>
	<m2isqwr4yh.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jul 2003 01:06:03 +0200
In-Reply-To: <m2isqwr4yh.fsf@telia.com>
Message-ID: <m265meszs4.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
> > a bigger problem is: X froze once, but I could login via network and
> > kill -9 it. No idea why, there is nothing special in the log file.
> 
> I've seen X freeze too. I'll debug it, but it will have to wait a week
> until I get back from my vacation.

I think this bug is fixed in version 0.11.3p5, which is available from
the usual place:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
