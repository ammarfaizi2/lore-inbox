Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285133AbRLMUCx>; Thu, 13 Dec 2001 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285132AbRLMUCn>; Thu, 13 Dec 2001 15:02:43 -0500
Received: from mustard.heime.net ([194.234.65.222]:10208 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285126AbRLMUCg>; Thu, 13 Dec 2001 15:02:36 -0500
Date: Thu, 13 Dec 2001 21:02:12 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.30.0112132041260.27734-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.30.0112132059440.27900-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


even more testing...

It seems like it's nopt the caching itself that is f..cked, as I can dod
pretty good i/o from other devices, like /dev/hda. (/dev/md0 is /dev/hde
and /dev/hdg in RAID-0 - see my first email)

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

