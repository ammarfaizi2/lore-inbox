Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTA2Ifg>; Wed, 29 Jan 2003 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTA2Iff>; Wed, 29 Jan 2003 03:35:35 -0500
Received: from mail2.webart.de ([195.30.14.11]:32268 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265305AbTA2Ife>;
	Wed, 29 Jan 2003 03:35:34 -0500
Message-ID: <398E93A81CC5D311901600A0C9F29289469392@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'Arador'" <diegocg@teleline.es>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Bootscreen
Date: Wed, 29 Jan 2003 09:35:40 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yeah, why to do it inside the kernel?
>
> Just run a userspace logo for the first thing in the
> system in the init screens. I don't see a real reason why 
> that thing should be put in kernel. Where would you put the
> 800x600 image (since you have nothing mounted)?
Dunno about you, but for me the kernel itself takes some time
to come up and handle things over to init. Not covering that
time would just feel... unfinished.

> If i remember correctly, xp doesn't shows the logo
> since the start neither. It does a bit of job before.
I'd rather not compare ourselves with XP all too closely.

> A linux kernel doesn't take too much time to boot
> (the ide detection is the slower part i remember)
You have SCSI disks only, I presume?

> And the kernel messages always were, always will be,
> useful. To get a clean screen perhaps we could have
> something like a boot parm called silentdmesg, and then
> do the previous thing.
Again, we've already encountered the diversity of (emotional)
opinions on this matter. I believe the final compromise "every-
one what s(he) needs" will do us just a fine service.

Not meaning to be offensive.
