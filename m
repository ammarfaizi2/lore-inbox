Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286557AbSAINjQ>; Wed, 9 Jan 2002 08:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286584AbSAINjG>; Wed, 9 Jan 2002 08:39:06 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19468 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286557AbSAINi6>; Wed, 9 Jan 2002 08:38:58 -0500
Date: Wed, 9 Jan 2002 14:38:56 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Patch (fwd)
Message-ID: <20020109133856.GA20598@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020109122608.GD5707@emma1.emma.line.org> <Pine.LNX.4.33.0201092239320.2618-100000@athlon.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201092239320.2618-100000@athlon.internal>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2002, David wrote:

> On Wed, 9 Jan 2002, Matthias Andree wrote:
> > 
> > So I took that patch that Anton Altaparmakov rediffed for 2.4.18-pre2;
> > it lacks help for these options:
> > 
> > CONFIG_IDEDISK_STROKE
> > CONFIG_IDE_TASK_IOCTL
> > CONFIG_IDE_TASKFILE_IO
> > CONFIG_BLK_DEV_IDEDMA_FORCED
> > CONFIG_IDEDMA_ONLYDISK
> > 
> > Would you mind adding help for these options?
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.0/0286.html

Sorry for missing these.

Two helpful people have now responded, I'd appreciate if the next
release of the patch contained these as patch hunks for Configure.help.
:-)

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
