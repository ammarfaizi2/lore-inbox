Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVBUX2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVBUX2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVBUX2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:28:13 -0500
Received: from Sophia.Soo.com ([199.202.113.33]:36619 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S262175AbVBUX2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:28:11 -0500
Date: Mon, 21 Feb 2005 18:28:07 -0500
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc4 seems broken for Nforce2 chipset
Message-ID: <20050221232806.GA27458@Sophia.soo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi;

i'm crashing my box twice a day running 2.6.11-rc4
when i turn on the Athlon-XP CPU bus disconnect.

When network activity is up over maybe 120KB/s and
i'm playing a video file at the same time, then
chances are good i'll lock up the box.

Box runs a Chaintech Summit 7NIF2 with 1G RAM and
an Audigy 2  sound card.  When it locks up sometimes
the sound card goes into a little loop where it
replays approx the half second of audio leading
up to the lockup.

b
