Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSEONU4>; Wed, 15 May 2002 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSEONUz>; Wed, 15 May 2002 09:20:55 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:54797 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314278AbSEONUy>;
	Wed, 15 May 2002 09:20:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kbuild Devel <kbuild-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "14 May 2002 20:46:38 MST."
             <1021434398.17954.14.camel@tduffy-lnx.afara.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 23:20:38 +1000
Message-ID: <22794.1021468838@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 20:46:38 -0700, 
Thomas Duffy <tduffy@directvinternet.com> wrote:
>I have only tested x86 as of this moment.  If anyone is dying for a
>clean kbuild-2.5-common-2.4.19-pre8-1, let me know and I can turn those
>wheels.

I have uploaded common-2.4.18-7 and common-2.5.15-4 to sourceforge.
http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
release 2.4.  This cross syncs the 2.4.18 and 2.5.15 architecture
independent code, where the two kernels have similar requirements.  I
will take Tom Duffy's 2.4.19-pre8 patch, add it to common-2.4.18-7 and
issue common-2.4.19-pre8-1 tomorrow.

