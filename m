Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbWAHNjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWAHNjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWAHNjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:39:41 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:45459 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S932732AbWAHNjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:39:40 -0500
In-Reply-To: <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
References: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de> <20060108020335.GA26114@dspnet.fr.eu.org> <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20198DF8-D632-412C-9FDA-DE0F3FC1D68B@neostrada.pl>
Cc: Olivier Galibert <galibert@pobox.com>, Takashi Iwai <tiwai@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 14:38:56 +0100
To: Jaroslav Kysela <perex@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-08, at 10:42, Jaroslav Kysela wrote:
>>
>> Once again no.  Nothing prevents the kernel to forward the data to
>> userland daemons depending on a userspace-uploaded configuration.
>
> But it's quite ineffecient. The kernel must switch tasks at least  
> twice
> or more. It's the major problem with the current OSS API.

1. It was only presented as an opportunity. Not every data has to go  
this way.
2. Aren't you the person which was showing off X11 as a good example  
to draw guidelines from?
