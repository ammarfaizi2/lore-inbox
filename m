Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWGAHn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWGAHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGAHn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:43:29 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:45329 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S964844AbWGAHn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:43:28 -0400
Message-ID: <44A6279C.3000100@superbug.co.uk>
Date: Sat, 01 Jul 2006 08:43:24 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org> <1151702966.32444.57.camel@mindpipe> <20060701073133.GA99126@dspnet.fr.eu.org>
In-Reply-To: <20060701073133.GA99126@dspnet.fr.eu.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
>> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
>> emulation, not the emu10k1 driver.
> 
> That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> of alsa's until alsa provides an equivalent interface.  That's a basic
> compatibility requirement.
> 
> 
>> ALSA's in-kernel OSS emulation does not have these features and
>> never will.
> 
> "Never" is terribly long.
> 
>   OG.

"Never" probably only means terribly long. :-)

If one takes the ALSA todo list, that is massive (it is so long in fact,
that we have not had time to write it all down!), sort it by priority,
then divide by the amount of ALSA developers time available, for this
particular feature, the time to implementation is getting very close to
"Never".

James
