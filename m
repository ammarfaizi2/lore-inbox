Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUBDH60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUBDH6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:58:25 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:31157 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266293AbUBDH6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:58:25 -0500
Date: Wed, 4 Feb 2004 08:59:17 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Joshua Kwan <joshk@triplehelix.org>
Cc: alsa-user@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ALSA in 2.6 -- no snd-au8830?
In-Reply-To: <20040204035336.GC4394@triplehelix.org>
Message-ID: <Pine.LNX.4.58.0402040857160.1863@pnote.perex-int.cz>
References: <20040204035336.GC4394@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Joshua Kwan wrote:

> $SUBJECT. The driver seems to be present in alsa-driver but not the
> in-kernel version. Is it very new? Does it need to be converted? Is it 
> deprecated in 2.6 in favor of a better driver? May I help out?

Actually, we are doing some cleanups in the code for 2.6. Then it will be 
propagated to our 2.6 BK patches.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
