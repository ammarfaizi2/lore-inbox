Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTLJSHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLJSHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:07:24 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:37769 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263851AbTLJSHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:07:21 -0500
Date: Wed, 10 Dec 2003 18:07:11 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Joe Thornber <thornber@sistina.com>
cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <20031210174418.GF476@reti>
Message-ID: <Pine.LNX.4.56.0312101802440.1218@fogarty.jakma.org>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
 <20031209143412.GI472@reti> <Pine.LNX.4.56.0312092106280.30298@fogarty.jakma.org>
 <20031209222624.GA6591@reti> <20031210084546.GG3988@suse.de>
 <Pine.LNX.4.56.0312101726340.1218@fogarty.jakma.org> <20031210174418.GF476@reti>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Joe Thornber wrote:

> The LVM1 driver was removed because dm covered the same
> functionality + lots more, and is more flexible.

Yes, DM seems quite nice.

> The LVM2 tools still understand the LVM1 metadata format, so there
> is no problem about not being able to read data in 2.6.

Ah, and this capability is /not/ going away? If so, then that works 
for me. Its just i got the vague impression that support was going 
to be excised at some stage soonish, which is what worries me. If 
not, apologies, and then indeed there's no reason for DM in 2.4.

> - Joe

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Will you loan me $20.00 and only give me ten of it?
That way, you will owe me ten, and I'll owe you ten, and we'll be even!
