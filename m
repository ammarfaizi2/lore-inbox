Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSEEPeY>; Sun, 5 May 2002 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSEEPeY>; Sun, 5 May 2002 11:34:24 -0400
Received: from jagor.srce.hr ([161.53.2.130]:27853 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S313060AbSEEPeX>;
	Sun, 5 May 2002 11:34:23 -0400
Message-Id: <200205051526.g45FQT89009651@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Kernel patching 2.4.19pre1 -> 2.4.19pre2
Date: Sun, 5 May 2002 17:26:45 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.NEB.4.44.0205051701330.283-100000@mimas.fachschaften.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 May 2002 17:03, Adrian Bunk wrote:
> Hi Danijel,

Hi Adrian :)

> > I'm trying to patch a 2.4.17 clean source tree to the latest 2.4.19-pre8
> > tree. I can patch it until the 2.4.19pre1.
> > When I try to apply patch-2.4.19pre2.bz2, this happens:
> >...
> > Where's the problem?
> >...
>
> the 2.4.19pre patches are all against 2.4.18, IOW:
> pre2 contains everything that is in pre1, too.
>
> You should apply the 2.4.19pre8 patch directly to the 2.4.18 kernel
> sources.

Thank you very much for the explanation!

Have a nice day,

-- 
Danijel Schiavuzzi
