Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTGATjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTGATjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:39:05 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:3076 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S262437AbTGATjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:39:00 -0400
Date: Tue, 1 Jul 2003 21:53:20 +0200
To: Edward King <edk@cendatsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Message-ID: <20030701195320.GB1336@alf.amelek.gda.pl>
References: <20030630221542.GA17416@alf.amelek.gda.pl> <3F0188FE.90603@cendatsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0188FE.90603@cendatsys.com>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 08:13:34AM -0500, Edward King wrote:
> 
> Are you using software raid or devfs?

No devfs.  As for RAID - I'm running the same kernel image on two
very similar boxes, RAID is compiled in but not used on one box,
and the other box currently has RAID1 in degraded mode (one disk,
waiting for me to install the second one).

Marek

