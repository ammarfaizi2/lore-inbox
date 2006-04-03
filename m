Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWDCQNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWDCQNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWDCQNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:13:44 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:6065 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751764AbWDCQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:13:43 -0400
Date: Mon, 3 Apr 2006 18:13:42 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: False OOM with swappiness == 0
In-Reply-To: <Pine.LNX.4.64.0604031811270.7588@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0604031812350.7588@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0604031811270.7588@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi
>
> On one our server we've seen that OOM killer kills a process even if there's 
> plenty of free swap space. The server had swappiness set to 0 which probably 
> triggered the bug.
>
> Mikulas

I forgot to tell kernel version: 2.6.15-gentoo-r1. Dual Opteron with 4G 
RAM.

Mikulas
