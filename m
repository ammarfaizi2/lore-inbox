Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319341AbSIFTUn>; Fri, 6 Sep 2002 15:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319343AbSIFTUn>; Fri, 6 Sep 2002 15:20:43 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:7622 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S319341AbSIFTUn>; Fri, 6 Sep 2002 15:20:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: jbradford@dial.pipex.com
Subject: Re: ide drive dying?
Date: Fri, 6 Sep 2002 21:22:31 +0200
User-Agent: KMail/1.4.1
References: <200209061722.g86HMuPp004452@darkstar.example.net>
In-Reply-To: <200209061722.g86HMuPp004452@darkstar.example.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209062122.31597.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 19:22, jbradford@dial.pipex.com wrote:
> > OK, I downloaded that and installed it, but well, frankly, it shows me
> > very little useful stuff.
> >
> > Or i'm just not good at interpreting this.
>
> Post the output of smartctl -a /dev/hda? to me, and I'll tell you what I
> can, but it's best to monitor the stats from when the drive is new, (I.E.
> every drive you buy from now on :-) ).
>

Well, there were 21 ATA errors, and it showed 5 error blocks, with disk 'live' 
times of 629 hours.

Luckely I've been able to backup everything from the disk, and I'm running the 
DFT now. The tests showed bad sectors, i'm currently running a disk erase.

DK
-- 
	"What's that thing?"
	"Well, it's a highly technical, sensitive instrument we use in
computer repair.  Being a layman, you probably can't grasp exactly what
it does.  We call it a two-by-four."
		-- Jeff MacNelley, "Shoe"

