Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265428AbSJaW3Z>; Thu, 31 Oct 2002 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265432AbSJaW3Z>; Thu, 31 Oct 2002 17:29:25 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:13752 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265428AbSJaW15> convert rfc822-to-8bit; Thu, 31 Oct 2002 17:27:57 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, please apply
Date: Thu, 31 Oct 2002 23:34:18 +0100
User-Agent: KMail/1.4.7
Cc: Hans Reiser <reiser@namesys.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Reiserfs-List@namesys.com
References: <3DC19F61.5040007@namesys.com>
In-Reply-To: <3DC19F61.5040007@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210312334.18146.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Oktober 2002 22:05 schrieb Jeff Garzik:
> Hans Reiser wrote:
>
> > If you want to talk about 2.6 then you should talk about reiser4 not 
> > reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 
> > for 30 copies of the linux kernel source code using modern IDE drives 
> > and modern processors on a dual-CPU box, so I don't think any amount 
> > of improved scalability will make ext3 competitive with reiser4 for 
> > performance usages. 
>
> What is the read performance like?

>From his mentioned paper http://www.namesys.com/v4/fast_reiser4.html, it is 
more then doubled compared to ext3 and ReiserFS v3.

To be fair he should explain if it was compared to the latest ext3 (htree) 
stuff or not, yet.

It looks truly impressive.

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
