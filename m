Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSEFMgH>; Mon, 6 May 2002 08:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314409AbSEFMgG>; Mon, 6 May 2002 08:36:06 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314404AbSEFMgF>; Mon, 6 May 2002 08:36:05 -0400
Message-ID: <3CD67874.A043C0C3@aitel.hist.no>
Date: Mon, 06 May 2002 14:35:00 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.12-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14 compile error
In-Reply-To: <022e01c1f4f1$40c2f9e0$f6de11cc@black>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Is RAID1/5 support even safe in the current 2.5 series?  I saw Neil post a
> message while ago but wasn't sure if he was being faceitous or not...
> I've not been able to get a single 2.5 series kernel to compile since 2.5.8

I use raid1 and raid0 with 2.5.12-dj1.  It compiles and seems
to work.  I don't know about raid-5 though.

Helge Hafting
