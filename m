Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVAKRUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVAKRUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVAKRRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:17:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41684 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262862AbVAKRRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:17:15 -0500
Subject: Re: Do PS/2 ESDI users exist?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050111043220.GB2760@pclin040.win.tue.nl>
References: <20050108214036.GW14108@stusta.de>
	 <20050108234337.GE6052@pclin040.win.tue.nl>
	 <20050111043220.GB2760@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105456814.15742.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 16:10:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 04:32, Andries Brouwer wrote:
> I wonder whether ps2esdi should be removed.
> Does the present driver work for someone?
> Have there been users in this millennium? With 2.3 or later?

Doubt it. esdi is the earlier end of the PS/2 world, and the tp720 is a
specific laptop with MCA bus from prehistory. I have used p2esdi years
ago but solely for the purpose of checking it worked.

