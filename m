Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSKFDxO>; Tue, 5 Nov 2002 22:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265573AbSKFDxO>; Tue, 5 Nov 2002 22:53:14 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:33833 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S265568AbSKFDxN>; Tue, 5 Nov 2002 22:53:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mike Diehl <mdiehl@dominion.dyndns.org>
To: slpratt@us.ibm.com
Subject: Re: [Evms-devel] Re: [Evms-announce] EVMS announcement
Date: Tue, 5 Nov 2002 20:29:41 -0500
X-Mailer: KMail [version 1.3.1]
References: <OFCC91E1D2.FC7FCB3C-ON05256C69.0001DCF6@pok.ibm.com>
In-Reply-To: <OFCC91E1D2.FC7FCB3C-ON05256C69.0001DCF6@pok.ibm.com>
Cc: corryk@us.ibm.com, evms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021106020931.860E05530@dominion.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 08:55 pm, you wrote:
     > Let me take a minute to reiterate: EVMS is not going away and has not
     > given up on any of it's original goals.  EVMS will still use a plug-in
     > architecture in the user space tools (Engine) to coordinate across
     > different types of kernel volume management drivers.  You will still
     > be able to use EVMS to partitions disks, create MD RAID arrays,
     > add these arrays to LVM containers, create regions and volumes and
     > mkfs your filesystems and a whole lot more, all from the EVMS
     > interface you know and love.

Good.  I'm beginning to feel better already.

     > >I wish the decision had gone the other way.  Get rid of LVM and get
     > > EVMS
     > into
     > >the mainstream.  Any chance that, after this "migration," we might do
     > > just that?
     >
     > Could happen, but don't hold your breath.

<giant exhale>

     > >I'd love to see the day when LVM and MD aren't kernel options by
     > >themselves, but rather options under EVMS, along with lots of other
     > > cools things.
     >
     > Sure, why not.  EVMS can manage both and can be expanded to manage
     > other device types as well.

I'm beginning to relize this.  Just a bit thick skulled at the moment.

     > >But never mind me.  I'm just a linux user, not a linux developer.
     > But users matter!!!  If we get the migration right (and we will) the

That was a cheep shot on my part.  But one thing that sets Linux apart from, 
say, FreeBSD, is that linux tends to have all of the features that USERS 
want.  I'm able to use my linux box as a firewall, IDS, DBMS, file server... 
etc.  But my AIX friends keep pointing at Volume Management and saying, "you 
can't do this...."  And indeed, with LVM, I couldn't when I tried.  I once 
lost a 360Gb database because I tried to resize it.  So call me sensitve.

     > only thing
     > you will notice different with EVMS are the kernel config options and
     > the ramdisk /ramfs stuff.  Everything else should look and fell and
     > work exactly
     > the same from a user's point of view.

I'm beginning to see some logic to this.  Remember, I've only been thinking 
about this for a few hours.  It sounds like the EVMS team has been thinking 
about it for quite some time.  I may have over-reacted.

-- 
Mike Diehl
PGP Encrypted E-mail preferred.
Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc

