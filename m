Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbTLIVHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbTLIVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:07:54 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:46988 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266136AbTLIVHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:07:53 -0500
Date: Tue, 9 Dec 2003 21:07:49 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Joe Thornber <thornber@sistina.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <20031209143412.GI472@reti>
Message-ID: <Pine.LNX.4.56.0312092106280.30298@fogarty.jakma.org>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
 <20031209143412.GI472@reti>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Joe Thornber wrote:

> Sort of, but please take into account the fact that the LVM1 driver
> has bugs (particularly on the failure paths), and EVMS and other
> volume managers dont use the LVM1 driver.  The snapshot target
> (which I didn't include in the core patches) is hugely better
> performance wise.

Would this be of any aid to 2.4 users to transition to DM, so that
they can then easily test 2.6 and boot back to 2.4 if needs be?

If so, my vote would be for it to be included in 2.4.

> - Joe

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
"The Right Honorable Gentleman is indebted to his memory for his jests
and to his imagination for his facts."
		-- Sheridan
