Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290279AbSAYHl2>; Fri, 25 Jan 2002 02:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290592AbSAYHlT>; Fri, 25 Jan 2002 02:41:19 -0500
Received: from coruscant.franken.de ([193.174.159.226]:17610 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S290591AbSAYHlB>; Fri, 25 Jan 2002 02:41:01 -0500
Date: Fri, 25 Jan 2002 08:36:39 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre7
Message-ID: <20020125083639.R11216@sunbeam.de.gnumonks.org>
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva> <20020124085649.GA30219@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020124085649.GA30219@titan.lahn.de>; from pmhahn@titan.lahn.de on Thu, Jan 24, 2002 at 09:56:49AM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 24th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 09:56:49AM +0100, Philipp Matthias Hahn wrote:
> Hi!
> 
> On Wed, Jan 23, 2002 at 07:55:46PM -0200, Marcelo Tosatti wrote:
> > pre7:
> > - Netfilter update 				(Netfilter team)
>
> net/ipv4/netfilter/ipt_{ah,esp,ULOG}.c are missing in the patch!
> Fails on install.

The files have been submitted but somehow didn't appear in the final
kernel tree.  David Miller and Marcelo will take care of it in the
next prerelease.

If you need the features until then, use a kernel <= 2.4.18-pre6 and
patch-o-matic from the latest iptables package or netfilter CVS.

> BYtE
> Philipp

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
