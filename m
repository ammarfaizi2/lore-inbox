Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTE1WbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTE1WbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:31:07 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:23959 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261279AbTE1WbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:31:06 -0400
Date: Wed, 28 May 2003 23:44:22 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: CRASH 2.5.70
Message-Id: <20030528234422.6173b72e.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Im getting a (pretty repeatable) hard lockup when I delete a LOT of
files in rox-filer.

sometimes random processes die just prior to the lockup. (xmms died just
prior to the last one)

there is no debug output at all.

other filesystem ops (eg. chmod/chown) dont seem to cause the lockups,
just delete.

I dont overclock this box, and it ran 2.4.<n> stably for months.

AthlonXP1800 on an Asus A7M266 with 256MB DDR memory.

-- 
Spyros lair: http://www.mnementh.co.uk/
Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.

Systems programmers keep it up longer.
