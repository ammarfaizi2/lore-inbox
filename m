Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIULGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIULGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIULGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:06:01 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60634 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267556AbUIULGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:06:00 -0400
Subject: Re: [sata] ALI M5281
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Shine on this Life That's Burnin' Out" <hopeless@islug.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409210340520.2842@inconnu.isu.edu>
References: <Pine.LNX.4.58.0409210340520.2842@inconnu.isu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095761018.30748.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 11:03:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 10:51, Shine on this Life That's Burnin' Out
wrote:
> Even some sort of semi-functional code would be nice. (Reminds me of 
> my attempts to forward-port old korean package for Aralion UltimaRAID 
> systems. Works in later 2.4's but dies on 2.6 =( )

A lot of badly written code (or just old code that didnt know
about the PCI mapping API) does that

> Was ALI good about specs for their old M15x3 series?

Reasonably so, at least when approached by a Linux vendor. I have some
ALi data sheets under NDA for example. I don't know how they view random
individual requests. 

Alan

