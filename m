Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVHHJnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVHHJnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 05:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVHHJnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 05:43:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31913 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750784AbVHHJnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 05:43:07 -0400
Date: Mon, 8 Aug 2005 11:43:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in task_struct
Message-ID: <20050808094301.GA1784@elf.ucw.cz>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net> <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz> <Pine.LNX.4.62.0507300843100.24809@graphe.net> <20050730161007.GA1885@elf.ucw.cz> <Pine.LNX.4.62.0507300916170.25259@graphe.net> <20050730162223.GB1885@elf.ucw.cz> <Pine.LNX.4.62.0508011141440.5458@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508011141440.5458@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Got a new suspend patchsset at 
> 
> ftp://ftp.kernel.org:/pub/linux/kernel/people/christoph/suspend/2.6.13-rc4-mm1
> 
> Check the series file for the sequence of patches.

Something still goes very wrong after first resume. It seems to work
ok for few seconds, then console switch takes 10 seconds to react and
cursor stops blinking, and then it is dead.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
