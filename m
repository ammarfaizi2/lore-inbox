Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbSI2JMq>; Sun, 29 Sep 2002 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbSI2JMq>; Sun, 29 Sep 2002 05:12:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262423AbSI2JMp>;
	Sun, 29 Sep 2002 05:12:45 -0400
Date: Sun, 29 Sep 2002 11:12:29 +0200
From: Jens Axboe <axboe@suse.de>
To: jbradford@dial.pipex.com
Cc: Linus Torvalds <torvalds@transmeta.com>, jdickens@ameritech.net,
       mingo@elte.hu, jgarzik@pobox.com, kessler@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       saw@saw.sw.com.sg, rusty@rustcorp.com.au, richardj_moore@uk.ibm.com,
       andre@master.linux-ide.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929091229.GA1014@suse.de>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209290716.g8T7GNwf000562@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, jbradford@dial.pipex.com wrote:
> > Anyway, people who are having VM trouble with the current 2.5.x series, 
> > please _complain_, and tell what your workload is. Don't sit silent and 
> > make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> > thing.
> 
> I think the broken IDE in 2.5.x has meant that it got seriously less
> testing overall than previous development trees :-(.  Maybe after
> halloween when it stabilises a bit more we'll get more reports in.

2.5 is definitely desktop stable, so please test it if you can. Until
recently there was a personal show stopper for me, the tasklist
deadline. Now 2.5 is happily running on my desktop as well.

2.5 IDE stability should be just as good as 2.4-ac.

-- 
Jens Axboe

