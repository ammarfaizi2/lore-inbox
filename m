Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTINK11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTINK11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 06:27:27 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:6344 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262355AbTINK1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 06:27:25 -0400
To: Nicolae Mihalache <mache@abcpages.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 problems: suspend and touchpad
References: <3F61CF12.9020602@abcpages.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Sep 2003 10:53:10 +0200
In-Reply-To: <3F61CF12.9020602@abcpages.com>
Message-ID: <m2d6e3vjih.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolae Mihalache <mache@abcpages.com> writes:

> I have a Acer Travelmate 800 laptop and I'm using SuSE Linux 8.2 on it.
> I tried recenly to install linux 2.6 and I observe two main problems:
> 1. The touchpad(synaptics) does not work. In kernel 2.4/X11 4.3  it
> works very well both as a generic ps2 mouse or as a synaptics (using
> X11 driver for synaptics). The kernel 2.6 seems to have included a
> driver for the synaptics device, it is detected at boot, but it does
> not work in X (I guess it must be some kind of conflict between X11
> driver and kernel driver?).

You need a new version of the X11 driver:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
