Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUHQPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUHQPrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUHQPqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:46:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28904 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268298AbUHQPbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:31:10 -0400
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch
	is this? - Unsure still
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408170402.33368.shawn.starr@rogers.com>
References: <200408170349.44626.shawn.starr@rogers.com>
	 <200408170402.33368.shawn.starr@rogers.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092752930.22573.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 15:28:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-17 at 09:02, Shawn Starr wrote:
> >  mice: PS/2 mouse device common for all mice
> > input: IBM PC110 TouchPad at 0x15e0 irq 10 <-----------------------------
> > This is new input: AT Translated Set 2 keyboard on isa0060/serio0

You enabled the IBM PC110 driver. Thats a driver for a specifc touchpad
device on IBM PC110 palmtop pcs - nothing to do with it 8)

