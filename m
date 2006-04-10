Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWDJXeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWDJXeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWDJXeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:34:14 -0400
Received: from [4.79.56.4] ([4.79.56.4]:43662 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932176AbWDJXeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:34:14 -0400
Subject: Re: [2.6 patch] move EXPORT_SYMBOL's away from
	sound/pci/emu10k1/emu10k1_main.c
From: Arjan van de Ven <arjan@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>,
       perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hodz992lx.wl%tiwai@suse.de>
References: <20060407003105.GG7118@stusta.de> <s5hu095y367.wl%tiwai@suse.de>
	 <20060407184909.GB9097@mars.ravnborg.org>  <s5hodz992lx.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 18:21:54 +0200
Message-Id: <1144686114.2876.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I know the above for the new codes, yes.  But my question is wheter do
> we get a good enough benifit by changing the existing code.
> 
> I'm not against such an action but just wornder whether it's really
> needed.  If yes, we should do it over the whole tree.
> 

that's what Adrian is doing, one subsystem at a time ;)
it was just your turn...

