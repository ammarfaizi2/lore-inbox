Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBTJaX>; Thu, 20 Feb 2003 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTBTJaX>; Thu, 20 Feb 2003 04:30:23 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:45702 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S265039AbTBTJaW>; Thu, 20 Feb 2003 04:30:22 -0500
Message-ID: <20030220094018.20008.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 17:40:18 +0800
Subject: Re: Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
> "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> wrote:
> >
> > Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-3 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-4 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-5 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-6 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-7 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-8 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-9 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-10 extents:1
> > Adding 272120k swap on /dev/hda7.  Priority:-11 extents:1
> >
> > What happened ?
> > 
> 
> Something ran swapon and swapoff a lot of times.  It appears that
> your initscripts have become confused.

The strange thing is that I noticed that with 2.5.62 but not
with 2.5.61. Mumble...

Ciao,
          Paolo
 

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
