Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSI2Oqf>; Sun, 29 Sep 2002 10:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSI2Oqf>; Sun, 29 Sep 2002 10:46:35 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:57329 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262490AbSI2Oqe>; Sun, 29 Sep 2002 10:46:34 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: jbradford@dial.pipex.com, Linus Torvalds <torvalds@transmeta.com>,
       jdickens@ameritech.net, mingo@elte.hu, jgarzik@pobox.com,
       kessler@us.ibm.com, linux-kernel@vger.kernel.org, saw@saw.sw.com.sg,
       rusty@rustcorp.com.au, richardj_moore@uk.ibm.com,
       andre@master.linux-ide.org
In-Reply-To: <20020929091229.GA1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
	<200209290716.g8T7GNwf000562@darkstar.example.net> 
	<20020929091229.GA1014@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 15:56:40 +0100
Message-Id: <1033311400.13001.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 10:12, Jens Axboe wrote:
> 2.5 is definitely desktop stable, so please test it if you can. Until
> recently there was a personal show stopper for me, the tasklist
> deadline. Now 2.5 is happily running on my desktop as well.

Its very hard to make that assessment when the audio layer still doesnt
work, most scsi drivers havent been ported, most other drivers are full
of 2.4 fixed problems and so on.

Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
unique. Middle of November we may begin to find out how solid the core
code actually is, as drivers get fixed up and also in the other
direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs

