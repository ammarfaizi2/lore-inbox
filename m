Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSEDMSt>; Sat, 4 May 2002 08:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSEDMSs>; Sat, 4 May 2002 08:18:48 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:18922 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312619AbSEDMSr>; Sat, 4 May 2002 08:18:47 -0400
Date: Sat, 4 May 2002 13:58:14 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4 
In-Reply-To: <23974.1020514265@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205041357110.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2002, Keith Owens wrote:

> You will have to provide more details of the problem that you think you
> are seeing.  The .tmp_include files are part of the infrastructure that
> lets me separate source and object trees, they are meant to be there.
> make -f Makefile-2.5 mrproper deletes .tmp_include.

I didn't try reproducing it, i just rm -rf'd .tmp_include when it failed. 
I'll double check.

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

