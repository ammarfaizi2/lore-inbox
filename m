Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbULMIib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbULMIib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 03:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbULMIib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 03:38:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52686 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262082AbULMIhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 03:37:39 -0500
Date: Mon, 13 Dec 2004 09:37:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <cone.1102896588.31702.10669.502@pc.kolivas.org>
Message-ID: <Pine.LNX.4.61.0412130936370.10621@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <20041212234256.GK6272@elf.ucw.cz> <cone.1102896588.31702.10669.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How does the popular proprietary operating system cope with this? My
> understanding is they run 1000Hz yet they have good power saving and quiet
> capacitors. Presumably they do a lot less per timer tick?

Either that or they maybe use a dynamic ticker, something that adjusts itself
between 100 and 1000 Hz.



Jan Engelhardt
-- 
ENOSPC
