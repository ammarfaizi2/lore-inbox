Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSEQEIL>; Fri, 17 May 2002 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSEQEIK>; Fri, 17 May 2002 00:08:10 -0400
Received: from rj.SGI.COM ([192.82.208.96]:63206 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315413AbSEQEIK>;
	Fri, 17 May 2002 00:08:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kbuild Devel <kbuild-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "Wed, 15 May 2002 23:20:38 +1000."
             <22794.1021468838@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 May 2002 14:07:46 +1000
Message-ID: <8230.1021608466@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002 23:20:38 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On 14 May 2002 20:46:38 -0700, 
>Thomas Duffy <tduffy@directvinternet.com> wrote:
>>I have only tested x86 as of this moment.  If anyone is dying for a
>>clean kbuild-2.5-common-2.4.19-pre8-1, let me know and I can turn those
>>wheels.
>
>I have uploaded common-2.4.18-7 and common-2.5.15-4 to sourceforge.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 2.4.  This cross syncs the 2.4.18 and 2.5.15 architecture
>independent code, where the two kernels have similar requirements.  I
>will take Tom Duffy's 2.4.19-pre8 patch, add it to common-2.4.18-7 and
>issue common-2.4.19-pre8-1 tomorrow.

kbuild-2.5-common-2.4.19-pre8-1.bz2, kbuild-2.5-i386-2.4.19-pre8-1.bz2
are available.  Use with core-14.

I built these from common-2.4.18-7, i386-2.4.18-2 plus some previous
work on 2.4.19-pre6 then updated to -pre8.  A cross check against Tom
Duffy's 19-pre8 patch found errors in my patches and Tom's, which have
been reconciled.

