Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSI2SJG>; Sun, 29 Sep 2002 14:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbSI2SJG>; Sun, 29 Sep 2002 14:09:06 -0400
Received: from gate.perex.cz ([194.212.165.105]:1552 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261481AbSI2SJG>;
	Sun, 29 Sep 2002 14:09:06 -0400
Date: Sun, 29 Sep 2002 20:13:18 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       "jbradford@dial.pipex.com" <jbradford@dial.pipex.com>,
       "jdickens@ameritech.net" <jdickens@ameritech.net>,
       "mingo@elte.hu" <mingo@elte.hu>,
       "jgarzik@pobox.com" <jgarzik@pobox.com>,
       "kessler@us.ibm.com" <kessler@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "saw@saw.sw.com.sg" <saw@saw.sw.com.sg>,
       "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
       "richardj_moore@uk.ibm.com" <richardj_moore@uk.ibm.com>,
       "andre@master.linux-ide.org" <andre@master.linux-ide.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <Pine.LNX.4.44.0209291047420.2240-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0209292009070.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Linus Torvalds wrote:

> 
> On 29 Sep 2002, Alan Cox wrote:
> > 
> > Its very hard to make that assessment when the audio layer still doesnt
> > work,
> 
> Which reminds me: it would be good to have somebody try to merge stuff
> from the ALSA tree.
> 
> ALSA never got out of their CVS mentality, and apparently nobody bothers 
> to do incrementeal merges. Is anybody interested and listening?

I am doing that. It seems that you have rejected my big patch, so I am 
trying to split our changed to small chunks. I have about 10 patches, I will
send them to you and lkml. All patches are in BK style with imported 
comments from CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

