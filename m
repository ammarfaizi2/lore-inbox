Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbSI2R40>; Sun, 29 Sep 2002 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbSI2R4X>; Sun, 29 Sep 2002 13:56:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48904 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261468AbSI2Rzs>; Sun, 29 Sep 2002 13:55:48 -0400
Date: Sun, 29 Sep 2002 10:48:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>, <jbradford@dial.pipex.com>,
       <jdickens@ameritech.net>, <mingo@elte.hu>, <jgarzik@pobox.com>,
       <kessler@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <saw@saw.sw.com.sg>, <rusty@rustcorp.com.au>,
       <richardj_moore@uk.ibm.com>, <andre@master.linux-ide.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <1033311400.13001.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209291047420.2240-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Sep 2002, Alan Cox wrote:
> 
> Its very hard to make that assessment when the audio layer still doesnt
> work,

Which reminds me: it would be good to have somebody try to merge stuff
from the ALSA tree.

ALSA never got out of their CVS mentality, and apparently nobody bothers 
to do incrementeal merges. Is anybody interested and listening?

		Linus

