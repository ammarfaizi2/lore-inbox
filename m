Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRDNJpl>; Sat, 14 Apr 2001 05:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDNJpV>; Sat, 14 Apr 2001 05:45:21 -0400
Received: from binky.de.uu.net ([192.76.144.28]:37675 "EHLO binky.de.uu.net")
	by vger.kernel.org with ESMTP id <S131631AbRDNJpR>;
	Sat, 14 Apr 2001 05:45:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MO-Drive under 2.4.3
Date: Sat, 14 Apr 2001 11:45:13 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14o3Jb-0002q9-00@the-village.bc.nu>
In-Reply-To: <E14o3Jb-0002q9-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01041411451300.01534@majestix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

thanks for the reply.

Am Freitag, 13. April 2001 15:08 schrieb Alan Cox:
> > I have a problem using my MO-Drive under kernel 2.4.3. I have several
> > disks formated with a VFAT filesystem. Under kernel 2.2.19 everything
> > works fine. Under kernel 2.4.3 I cannot write anything to the disk
> > without hanging the complete system so that I have to use the reset
> > button. For disks with an ext2 filesystem it works okay.
>
> This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any
> of the scsi maintainers seem to care about it right now.

Does this mean I can forget about using kernel 2.4.x? :-(( Can you give me a 
hint where to look. Maybe I can fix it myself.

Regards
Detlev
-- 
Detlev Offenbach
detlev@offenbach.fs.uunet.de
