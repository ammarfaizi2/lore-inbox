Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBCIaX>; Mon, 3 Feb 2003 03:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTBCIaX>; Mon, 3 Feb 2003 03:30:23 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2230 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S266135AbTBCIaX>; Mon, 3 Feb 2003 03:30:23 -0500
Date: Mon, 3 Feb 2003 09:39:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: Daniel Egger <degger@fhm.edu>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
Message-ID: <20030203083910.GB2287@wohnheim.fh-wedel.de>
References: <20030202223009.GA344@elf.ucw.cz> <1044232591.545.8.camel@sonja> <yq1smv6qfvc.fsf@austin.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1smv6qfvc.fsf@austin.mkp.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 February 2003 21:04:23 -0500, Martin K. Petersen wrote:
> >>>>> "Daniel" == Daniel Egger <degger@fhm.edu> writes:
> 
> Daniel> CF has limited write cycles. A few hundred if you're lucky.
> 
> However, I have yet to see a CF card which didn't survive beyond a
> million writes.
> 
> Note that CF cards do transparent wear averaging inside.  So it's
> obviously not a million writes to the same physical spot.  Also, most
> vendors claim they have spare blocks for relocating areas that are
> completely worn out.

This apears to be the same statement, except that Daniel forgot to add
"per block".

Jörn

-- 
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS d- s+: a- C++ UL++++ P+(++) L++++$ !E W++ N+ o? K? w- O- M- V?
PS+(++) PE++ Y+ PGP>+ t+@ 5? X+ R@ !tv b+ DI+ !D G- e h-- r y+
------END GEEK CODE BLOCK------
