Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbULKVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbULKVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbULKVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:41:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26544 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262021AbULKVlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:41:21 -0500
Date: Sat, 11 Dec 2004 22:41:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <20041211142317.GF16322@dualathlon.random>
Message-ID: <Pine.LNX.4.53.0412112012180.30929@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>The below patch allows to set the HZ dynamically at boot time with

so the only thing left is to alter HZ at runtime :)

>Is there any interest from the mainline developers to merge this into 2.6?

For my side, there is interest from the average user.



Jan Engelhardt
-- 
ENOSPC
