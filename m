Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSBELC4>; Tue, 5 Feb 2002 06:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSBELCo>; Tue, 5 Feb 2002 06:02:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:37095 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S289380AbSBELC3>; Tue, 5 Feb 2002 06:02:29 -0500
Date: Tue, 5 Feb 2002 11:59:51 +0100
From: Harald Welte <laforge@gnumonks.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre8
Message-ID: <20020205115951.J26676@sunbeam.de.gnumonks.org>
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva> <20020205013258.H349@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020205013258.H349@stingr.net>; from i@stingr.net on Tue, Feb 05, 2002 at 01:32:58AM +0300
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 28th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 01:32:58AM +0300, Paul P Komkoff Jr wrote:
> > No more big patches for 2.4.18, please... We are getting close to the -rc
> > stage.
> 
> We all getting close to another bug. Maybe.
> Beat me if I am wrong, but netfilter_ipv4.h update (route_me_harder) break
> userland iptables compile process.
> 
> I am now worked around with following, but it is completely untested, also
> sent to harald welte and I suggest further comments from him - fix the
> userspace, kernel, or ...

I'll submit a patch for this later today.  We'll move the function out of
the include file.

> Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
