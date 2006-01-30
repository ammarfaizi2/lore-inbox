Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWA3QaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWA3QaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWA3QaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:30:23 -0500
Received: from mail.gmx.de ([213.165.64.21]:3969 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932363AbWA3QaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:30:23 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 17:30:06 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060130163006.GA19173@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner> <20060130120408.GA8436@merlin.emma.line.org> <43DE3AE5.nail16ZL1UH7X@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE3AE5.nail16ZL1UH7X@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > Cdrecord is a program that needs to be able to send any SCSI command as 
> > > it needs to be able to add new vendor unique commands for new drive/feature
> > > support.
> >
> > Right, but evidently it does not need the kernel to invent numbering.
> > dev=/dev/hdc works today.
> 
> Maybe, I will need to enforce to use official libscg device names in future....

If you deem fighting your own user base the appropriate behavior to
enforce your distorted view on groups that outnumber you by at least
five orders of magnitude, go right ahead.

But don't complain if you're losing control that way because Albert or
somebody else really forks cdrecord then and the fork becomes more
popular than the original.

cdrecord wouldn't be the first package to see such things happen.

-- 
Matthias Andree
