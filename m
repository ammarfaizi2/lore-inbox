Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbTDBSHt>; Wed, 2 Apr 2003 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263098AbTDBSHt>; Wed, 2 Apr 2003 13:07:49 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:26884 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S263084AbTDBSHr>; Wed, 2 Apr 2003 13:07:47 -0500
Date: Wed, 2 Apr 2003 19:19:12 +0100
From: John Levon <levon@movementarian.org>
To: mikpe@csd.uu.se
Cc: Pavel Machek <pavel@suse.cz>, "Martin J. Bligh" <mbligh@aracnet.com>,
       torvalds@transmeta.com, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Convert APIC to driver model: now it works with SMP
Message-ID: <20030402181912.GK35912@compsoc.man.ac.uk>
References: <20030330193026.GA29499@elf.ucw.cz> <14730000.1049180682@[10.10.2.4]> <20030401153852.GA24356@compsoc.man.ac.uk> <20030401202544.GD122@elf.ucw.cz> <16010.57535.281723.305868@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16010.57535.281723.305868@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *190mpN-0006Or-00*bHUiVarVt4.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 03:08:15PM +0200, mikpe@csd.uu.se wrote:

> John wrote that the latest works for him, with oprofile enabled.
> Maybe he fixed some detail, I haven't compared it with mine yet.

The only fix I made was to let CONFIG_PM=n compile.

regards,
john
