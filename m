Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270687AbTG0HVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 03:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270689AbTG0HVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 03:21:42 -0400
Received: from maile.telia.com ([194.22.190.16]:29652 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S270687AbTG0HVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 03:21:41 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: David Benfell <benfell@greybeard95a.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOLVED: touchpad doesn't work under 2.6.0-test1-ac2
References: <bXg8.4Wg.1@gated-at.bofh.it>
	<S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org>
	<20030724212416.GA18141@vana.vc.cvut.cz>
	<20030725070806.GB15819@parts-unknown.org>
	<20030727040531.GA14776@parts-unknown.org>
From: Peter Osterlund <petero2@telia.com>
Date: 27 Jul 2003 09:36:38 +0200
In-Reply-To: <20030727040531.GA14776@parts-unknown.org>
Message-ID: <m2wue4e7zt.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Benfell <benfell@greybeard95a.com> writes:

> On Fri, 25 Jul 2003 00:08:06 -0700, David Benfell wrote:
> > Hello all,
> > 
> > First someone pointed me at the driver available through
> > 
> > http://w1.894.telia.com/~u89404340/touchpad/index.html
> > 
> This driver does not work on the HP ZT1180.
> 
> What does work is enabling CONFIG_INPUT_EVDEV in the kernel
> configuration.  The trick then is to NOT combine this with the
> Synaptics driver mentioned above.

I want the driver to work on as many computers as possible. Can you
please send me the XFree86 log file you get when you try to use the
XFree driver and CONFIG_INPUT_EVDEV at the same time.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
