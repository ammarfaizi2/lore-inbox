Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315555AbSENJRS>; Tue, 14 May 2002 05:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315557AbSENJRR>; Tue, 14 May 2002 05:17:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:5893 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315555AbSENJRQ>; Tue, 14 May 2002 05:17:16 -0400
Date: Tue, 14 May 2002 11:17:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 2
Message-ID: <20020514091704.GA2947@louise.pinerecords.com>
In-Reply-To: <7926.1021355489@kao2.melbourne.sgi.com> <001501c1fb26$d5548660$8ff583d0@pcs686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 11:57)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if Linus isn't ready for it to be included in the kernel, I am planning
> to star releasing a patchset similar to that of Dave Jones. Kbuild will be
> the first thing that I will work into my patchset. I will keep both ways of
> building the kernel as I work on it, since another set of patches that I am
> going to add breaks kbuild, until I fix it.

That's nice, but doesn't quite solve Keith's problem:

<quote>
	Keeping up to date with kernel changes is a significant effort,
	Makefiles change all the time, especially when major subsystems like
	sound and usb are reorganised.  There are also some changes to
	architecture code to do it right under kbuild 2.5 and tracking those
	against kernel changes can be painful.
</quote>

-Tomas
