Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbULMI3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbULMI3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 03:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbULMI3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 03:29:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15566 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262076AbULMI3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 03:29:15 -0500
Date: Mon, 13 Dec 2004 09:29:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <41BCD5F3.80401@kolivas.org>
Message-ID: <Pine.LNX.4.61.0412130928350.2394@yvahk01.tjqt.qr>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just being devils advocate here...
>
> I had variable Hz in my tree for a while and found there was one solitary
> purpose to setting Hz to 100; to silence cheap capacitors.
>
> The rest of my users that were setting Hz to 100 for so-called performance
> gains were doing so under the false impression that cpu usage was lower simply
> because of the woefully inaccurate cpu usage calcuation at 100Hz.

I have found that mplayer drops audio less often when the harddisk is under 
load.




Jan Engelhardt
-- 
ENOSPC
