Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTLRHb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbTLRHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:31:56 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:48768
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264956AbTLRHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:31:55 -0500
Date: Thu, 18 Dec 2003 02:31:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 keyboard not working
In-Reply-To: <20031218060053.GA645@gnu.org>
Message-ID: <Pine.LNX.4.58.0312180230150.1710@montezuma.fsmlabs.com>
References: <20031218060053.GA645@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Lennert Buytenhek wrote:

> Hi,
>
> Halfway between having uncompressed the kernel and starting init, the console
> starts to scroll "atkbd.c: Unknown key pressed", mentioning key code 0 (IIRC),
> even though no keys are pressed at all.  After a while, the scrolling stops,
> but the keyboard still doesn't work.  2.4 works fine on the same hardware.
>
> Hardware is an Intel SE7505VB2 board with dual 2.40GHz Xeon processors,
> and a Logitech PS/2 "Internet keyboard."
>
> Ideas?

May we have a look at your .config?

ta,
	Zwane
