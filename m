Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTFYKh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFYKhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:37:06 -0400
Received: from [198.184.232.17] ([198.184.232.17]:42140 "EHLO
	swordfish.capgemini.hu") by vger.kernel.org with ESMTP
	id S264477AbTFYKeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:34:50 -0400
Date: Wed, 25 Jun 2003 12:48:55 +0200
From: Nagy Gabor <linux42@freemail.c3.hu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21 vesafb freeze
Message-ID: <20030625104854.GR930@swordfish.capgemini.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use fbi to view pictures on the framebuffer. I've been using 2.4.17 for
a very long time, and I haven't noticed this problem with 2.4.20 and 2.5.70

I have a Compaq Armada M700 laptop, with an ATI Rage Mobility videocard.
Years ago I tried the ATI framebuffer things in the kernel, without much
success, so I've been using the vesa framebuffer ever since.

With 2.4.21 the effect is this: I start fbi with some picture, the panel
goes white in a its-not-working fashion (so not the same as viewing an all
white picture), and my computer stops responding. Cannot be pinged,
keyboard doesn't work any more.

Switch off.

Gee
