Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSJKDpF>; Thu, 10 Oct 2002 23:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262331AbSJKDpF>; Thu, 10 Oct 2002 23:45:05 -0400
Received: from host145.south.iit.edu ([216.47.130.145]:17083 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S262328AbSJKDpE>;
	Thu, 10 Oct 2002 23:45:04 -0400
Date: Thu, 10 Oct 2002 22:50:42 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021010225042.A30948@lostlogicx.com>
References: <Pine.LNX.4.44L.0210081034360.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44L.0210081034360.1909-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 08, 2002 at 10:35:40AM -0300
X-Operating-System: Linux found 2.4.19-gentoo-r9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I just saw the recent announcement of procps-3.0.1 on the mailing 
list by the procps.sourceforge.net team, what is the status of these two 
projects, there are features in each that are very nice, the versioning is 
confusing, and inconsistant, and the package names are the same...

Kinda hoping to learn which tree a distribution developer should follow, 
etc.

TIA,

Brandon Low
Gentoo Linux Kernel Release Manager

p.s. please CC

On Tue, 10/08/02 at 10:35:40 -0300, Rik van Riel wrote:
> 		Procps 2.0.10
> 		8 Oct 2002
> 
> 
> Procps is the package containing various system monitoring tools, like
> ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
> period of inactivity procps maintenance is active again and suggestions,
> bugreports and patches are always welcome on the procps list.
> 
> The plan is to release a procps 2.1.0 around the time the 2.6.0 kernel
> comes out, with regular releases until then. Code cleanups and all kinds
> of enhancements are welcome.
> 
> 
> You can download procps 2.0.10 from:
> 
> 	http://surriel.com/procps/procps-2.0.10.tar.bz2
> 
> If you have feedback (or patches) for the procps team, feel free to
> mail us at:
> 
> 	procps-list@redhat.com
> 
> 
> NEWS for version 2.0.10 of procps
> 
> * fix memory size overflow in ps (Anton Blanchard)
> * add iowait statistics to top (Rik van Riel)
> * update top help text (Denis Vlasenko)
> * fix jumpy percentage formatting in top (Denis Vlasenko)
> * fix some newer gcc compiler warnings (Denis Vlasenko)
> * by default, do not show threads in ps or top - you can use the
>   `-m' flag in ps or the `H' key in top to show them (Robert Love)
> 
> 
> 
> Rik
> -- 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
