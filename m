Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEPUUC>; Thu, 16 May 2002 16:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSEPUUC>; Thu, 16 May 2002 16:20:02 -0400
Received: from mail-src.takas.lt ([212.59.31.78]:29895 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S314657AbSEPUUB>;
	Thu, 16 May 2002 16:20:01 -0400
Date: Thu, 16 May 2002 22:13:57 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: Paul Faure <paul@engsoc.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.LNX.4.33.0205161552470.17862-100000@lager.engsoc.carleton.ca>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Message-ID: <ISPFE871mrvoGdKO8FN00000650@mail.takas.lt>
X-OriginalArrivalTime: 16 May 2002 20:20:00.0611 (UTC) FILETIME=[0E1F9330:01C1FD17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002 16:08:15 -0400 (EDT) Paul Faure <paul@engsoc.org> wrote:

> Just installed RedHat 7.3 with kernel 2.4.18 and noticed that my network 
> no longer functions when my CPU usage is at 100%.  Looking at the 
> priorities of the application that I was running showed a priority of 35 
> (thats what `nice ./test` produces).  Then looking at the priorities of 
> all the other processes shows a range from 15 to 35.

> I am running an SMP box.

Didn't care to look at RedHat errata?

Regards,
Nerijus

