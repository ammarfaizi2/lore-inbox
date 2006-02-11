Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWBKWHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBKWHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWBKWHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:07:36 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2724 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750728AbWBKWHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:07:36 -0500
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
From: Lee Revell <rlrevell@joe-job.com>
To: Nick <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <7c3341450602110556u75c4bfffq@mail.gmail.com>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
	 <7c3341450602110556u75c4bfffq@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 17:07:32 -0500
Message-Id: <1139695653.19342.130.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 13:56 +0000, Nick wrote:
> Now the question - there have been a lot of alsa changes (since my
> alsa-tools was built Slack 10) - do we need to keep the alsa tools and
> stuff current too? 

Yes - kernel upgrades should depend on alsa-lib upgrades (many distros
seem to get this wrong).  This should be fixed in the future, but it's
been this way for some time.

Lee

