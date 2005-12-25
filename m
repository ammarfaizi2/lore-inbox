Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVLYV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVLYV5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVLYV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:57:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:55752 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750946AbVLYV5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:57:44 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
In-Reply-To: <20051225212041.GA6094@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 08:57:23 +1100
Message-Id: <1135547844.8365.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-25 at 22:20 +0100, Michael Hanselmann wrote:
> This patch adds a basic input hook support to usbhid because the quirks
> method is outrunning the available bits. A hook for the Fn and Numlock
> keys on Apple PowerBooks is included.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This makes the keyboard useable on latest generations of Apple
PowerBooks, so please apply asap :)

Ben.


