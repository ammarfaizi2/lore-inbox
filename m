Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVDYTSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVDYTSB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVDYTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:15:58 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53939 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262739AbVDYTOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:14:14 -0400
Date: Mon, 25 Apr 2005 21:14:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>
cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050421175723.GB13052@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0504252113160.26096@numbat.sonytel.be>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
 <20050421175723.GB13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005, Al Viro wrote:
> As far as I can see that's the minimally intrusive header changes needed
> to avoid problems - better than variant with splitting sched.h as in m68k CVS.

We can discuss about that. IIRC, HCH is also in favor of splitting off struct
task_struct from sched.h.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
