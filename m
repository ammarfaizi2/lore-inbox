Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVCLT3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVCLT3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCLT3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:29:25 -0500
Received: from zork.zork.net ([64.81.246.102]:8932 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262008AbVCLT3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:29:22 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: DRI breakage, 2.6.11-mm[123]
References: <20050312034222.12a264c4.akpm@osdl.org>
	<6uzmx87k48.fsf@zork.zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Dave Airlie
	<airlied@gmail.com>, linux-kernel@vger.kernel.org
Date: Sat, 12 Mar 2005 19:29:20 +0000
In-Reply-To: <6uzmx87k48.fsf@zork.zork.net> (Sean Neakums's message of "Sat,
	12 Mar 2005 19:13:43 +0000")
Message-ID: <6uu0ng7je7.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> The following happens with 2.6.11-mm[123].  (I didn't have time to
> investigate earlier; sorry.)  It does not happen with 2.6.11-rc3-mm2
> and 2.6.11.  I have tested 2.6.11-mm3 with dri disabled (by not
> loading X's dri module) and it also does not happen then.

Also happens on 2.6.11-mm3 with bk-drm.patch reverted.

To expand on my crappy report, the graphics card is a Radeon 9200:

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)

-- 
Dag vijandelijk luchtschip de huismeester is dood
