Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSENIoL>; Tue, 14 May 2002 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSENIoK>; Tue, 14 May 2002 04:44:10 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24074 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315479AbSENIoK>; Tue, 14 May 2002 04:44:10 -0400
Date: Tue, 14 May 2002 10:44:07 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020514084407.GC1842@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020513144519.GC5134@louise.pinerecords.com> <Pine.LNX.4.44.0205131759480.5254-100000@alumno.inacap.cl> <20020513234125.GD713@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Tomas Szepe wrote:

> > - Added an usage note
> > - Changed CMODE environment variable for a command line argument
> 
> Thanks, but the idea behind CMODE is that it's possible to set the
> output mode and still have the script act both as a filter and file
> eater (multiple changelogs on cmdline are ok of course) w/o having
> to handle the eating "explicitly."
> 
> Plus one can put "export CMODE=something" in ~/.profile and forget
> about the modes entirely.
> 
> Here comes 0.92 (s/LOWER CAPS/lower case/ as pointed out by
> Kai Henningsen). Let's call it a candidate for inclusion in
> scripts/. Linus?

Too early. It's undocumented, for example.
