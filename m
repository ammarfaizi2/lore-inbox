Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbTJSWLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbTJSWLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:11:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:39562 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262243AbTJSWLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:11:38 -0400
Date: Mon, 20 Oct 2003 00:11:37 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <34569.192.168.9.10.1066600317.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <15564.1066601497@www68.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > i have the same problems with epox 8k9a3+,
> > and may be even strange ones
> > (like fs coruption when soft raid & / or lvm is used)
> 
> I've seen the filesystem corruption with ext3 & xfs
> and RAID1 (md) as well. However, I don't seem to
> be able to get that far nowadays, as the machine
> is being used as NFS-server and thefore there is
> always "too much" disk-transfers going on and an
> IDE-system hang happens quite soon after boot.
> (it seems that my raid-disks get out of sync every time
> I switch from proprietary driver --> kernel driver
> and so it might be the raid resync that hangs the system).
> 
> > and i never had the problems with 8k5a3+,
> > the drives were actually taken from the 8k5a3+
> > when it died (me silly tried to update to XP2700)
> >
> > really strange, isn't it
> >
> > both boards should be the same, except
> > 8k5a3+ uses kt333
> > 8k9a3+ uses kt400
> 
> Yep, but it cannot be strictly via-chipset issue
> as I have verified that the same problem exists
> with Epox 4PCA3+ motherboard, which is P4 & Intel 875P
> based.

may be epox got broken HPT's ?
anyone with mainboard from other vendor seeing this problems ?

my HPT BIOS is v1.24
mainboard BIOS last updated in september i think

svetljo

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

