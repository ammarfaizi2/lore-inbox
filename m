Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVFLHK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVFLHK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVFLHK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 03:10:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:13221 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261894AbVFLHKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 03:10:54 -0400
Date: Sun, 12 Jun 2005 09:10:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: subbie subbie <subbie_subbie@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
In-Reply-To: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0506120909460.21370@yvahk01.tjqt.qr>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>human to be able to read them (let alone vgrep them).

dmesg | grep

> Let the flames begin

/* Write it, it's just a mdelay() or sort of in printk(). */



Jan Engelhardt                                                               
--                                                                            
