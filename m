Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWCFQTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWCFQTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWCFQTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:19:39 -0500
Received: from mail.freedom.ind.br ([201.35.65.90]:35971 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP
	id S1750984AbWCFQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:19:38 -0500
From: Otavio Salvador <otavio@debian.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, "S. Umar" <umar@compsci.cas.vanderbilt.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Organization: O.S. Systems Ltda.
References: <200602270900.13654.umar@compsci.cas.vanderbilt.edu>
	<s5hu0akssey.wl%tiwai@suse.de> <20060304144625.GX9295@stusta.de>
	<s5hfylvmzi5.wl%tiwai@suse.de>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Mon, 06 Mar 2006 13:19:30 -0300
In-Reply-To: <s5hfylvmzi5.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	06 Mar 2006 15:14:26 +0100")
Message-ID: <878xrnczql.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

>> Shouldn't this fix go into 2.6.16?
>
> Unfortunately it's involved with many other patches (especially
> semahpore->mutex ones) and hard to cherry-pick...

I could prepare another patch just to fix it and then put it in on
2.6.16.


-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
