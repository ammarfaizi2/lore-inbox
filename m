Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQLHHwk>; Fri, 8 Dec 2000 02:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLHHw3>; Fri, 8 Dec 2000 02:52:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9733 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129707AbQLHHwT>; Fri, 8 Dec 2000 02:52:19 -0500
Date: Fri, 8 Dec 2000 01:17:38 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS repair tools
Message-ID: <20001208011738.A2500@vger.timpanogas.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <20001207230407.S6567@cadcamlab.org> <3A306CE4.47B366B0@timpanogas.org> <14896.31327.179696.632616@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14896.31327.179696.632616@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Dec 08, 2000 at 12:06:23AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 12:06:23AM -0600, Peter Samuelson wrote:
> 
> [Jeff Merkey]
> > Please consider the attached patch to make it a little bit harder for
> > folks to enable NTFS Write Support under Linux until it can get fixed
> > properly.
> 
> Hey!  It was a joke!  A better way would be just to comment out the
> CONFIG_NTFS_RW line entirely.  Actually, I think that *would* be a good
> idea.  Anyone who has any business messing with NTFS_RW is more than
> capable of editing Config.in


Even better, this will disable it.   For now, it's probably for the
best.  Microsoft has been extremely tolerant in allowing me to help
these customers, but if it turns into a wide-scale software distribution
business, I can see them sending lawyers my way.  If I personally touch 
the NTFS driver in Linux before some reasonable legal limit expires, 
they could do some very unpleasant things.

:-)

Jeff

> 
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
