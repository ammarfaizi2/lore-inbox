Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281624AbRKZMCP>; Mon, 26 Nov 2001 07:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281638AbRKZMCD>; Mon, 26 Nov 2001 07:02:03 -0500
Received: from mx0.gmx.net ([213.165.64.100]:762 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S281624AbRKZMB4>;
	Mon, 26 Nov 2001 07:01:56 -0500
Date: Mon, 26 Nov 2001 13:01:49 +0100 (MET)
From: ragnagock@gmx.de
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Re: Bootdisk minikernel to load full kernel via /linuxrc
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0004399983@gmx.net
X-Authenticated-IP: [149.225.116.172]
Message-ID: <32173.1006776109@www3.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Hi,
> > 
> > How would a /linuxrc look like, if I want a small bootdisk to load
> > a kernel from hdd? It has to boot just like loaded by loadlin or lilo
> > so noone can boot the PC without the disk but I can fiddle around
> > just like "normal"...
> > 
> > I'd be happy, if someone could help me.
> 

Sorry, I forgot to mention that I want to have all partitions encrypted.
And since there will be some kernel changes later on I don't want to
create a boot disk every time. This means it can't be very big -> no CD-R.

> A) a small filesystem to mount the encrypted filesystems, and then start
> the main system.

How?
Take a std floppy disk and boot a normal system from it... I ran out of
space.

> B) A dual-boot system, booting windows, with a normal kernel simply set to

> boot from the partition linux is installed on.

But why would I encrypt the linux part/haven't lilo installed then? 

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

