Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTLCDiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTLCDiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:38:14 -0500
Received: from dhcp024-209-033-037.neo.rr.com ([24.209.33.37]:46979 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264489AbTLCDiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:38:12 -0500
Date: Tue, 2 Dec 2003 22:31:03 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: file2alias for pnp (Re: modules.pnpmap output support)
Message-ID: <20031202223103.GB1718@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Takashi Iwai <tiwai@suse.de>, Andrey Borzenkov <arvidjaar@mail.ru>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <s5hoevbjdjj.wl@alsa2.suse.de> <s5h65hf1iou.wl@alsa2.suse.de> <s5hn0ahdgbm.wl@alsa2.suse.de> <200311272159.00184.arvidjaar@mail.ru> <s5hk75kbsm1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk75kbsm1.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 01:11:18PM +0100, Takashi Iwai wrote:
> Adam, any plan to give the card id to sysfs ?
>

Sure, would you prefer to see it in the isapnp device's parent
card device under "id" or in the device's own directory under
"card_id"?

Thanks,
Adam
