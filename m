Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132159AbRAQAkZ>; Tue, 16 Jan 2001 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132094AbRAQAkQ>; Tue, 16 Jan 2001 19:40:16 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:40206 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S130007AbRAQAkG>; Tue, 16 Jan 2001 19:40:06 -0500
Date: Tue, 16 Jan 2001 19:42:10 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        "'linux-scsi @ vger . kernel . org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116194210.C1609@munchkin.spectacle-pond.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010117003205.A711@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010117003205.A711@werewolf.able.es>; from jamagallon@able.es on Wed, Jan 17, 2001 at 12:32:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 12:32:05AM +0100, J . A . Magallon wrote:
> If that is your idea of the average user... You're a system administrator, 
> you can have tons of scsi cards in your system if you want.
> 
> You want to make things SOOO easy for a 'dummy' user, and that user will never 
> use them. The average user you are targetting says: 'daddy, buy me a PC to
> run Quake and do my school jobs' or 'please, dear vendor, I want a PC to
> do my housekeeping'. I have seen so many cases (A buys PC, A tries to run
> brand new racing game that does not work, A goes shop and says: don't know
> what's wrong with this PC, look at it and call me when MyCarRacingGame 
> works...).

I also don't want things so complex for the people who need to do complex
things, that they give up in frustration with Linux and use something else like
*BSD, particularly when things are changed from the previous way they were done
in Linux.  I agree things should be simple for simple configurations, but that
does not mean we should be throwing boat anchors and couches in the paths of
people who have more complex hardware.

> Average users you are targetting with that automagical
> card detection even do not know there are SCSI and IDE disks. They just
> want a 30Gb ide disk to install linux and play. If they involve with SCSI
> and ID numbers and multiple cards and so on they can read some docs and
> rebuild a kernel.

Ummm, I just reread the 2.4 Changes file once again just to be sure, and it did
not cover this issue.  So how the *$@% are people supposed to "read some docs"
to know about this, if the docs don't mention the information.  I know people
have been complaining about this change since at least the fall time frame.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
