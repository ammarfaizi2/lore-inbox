Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVBEGY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVBEGY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbVBEGYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:24:08 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29135 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S264722AbVBEGXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:23:25 -0500
Date: Sat, 5 Feb 2005 07:23:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Victor Krapivin <vik@belcaf.minsk.by>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] input/gameport/cs461x.c: make 2 functions static
Message-ID: <20050205062346.GB2344@ucw.cz>
References: <20050205024132.GI19408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205024132.GI19408@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 03:41:32AM +0100, Adrian Bunk wrote:
> This patch makes two needlessly global functions static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
