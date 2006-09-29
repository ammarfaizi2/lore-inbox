Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWI2Me0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWI2Me0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWI2Me0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:34:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12251 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964860AbWI2MeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:34:25 -0400
Date: Fri, 29 Sep 2006 14:26:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [PATCH] Reset file->f_op in snd_card_file_remove(). Take 2
Message-ID: <20060929122616.GA28111@elte.hu>
References: <200609282228.02611.annabellesgarden@yahoo.de> <s5hmz8j3q59.wl%tiwai@suse.de> <200609291429.21183.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609291429.21183.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4963]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Florin's patch fixes it.

great - i've applied Florin's patch to -rt.

	Ingo
