Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRANIhF>; Sun, 14 Jan 2001 03:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131252AbRANIgz>; Sun, 14 Jan 2001 03:36:55 -0500
Received: from coruscant.franken.de ([193.174.159.226]:47120 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130378AbRANIgj>; Sun, 14 Jan 2001 03:36:39 -0500
Date: Sun, 14 Jan 2001 09:36:23 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010114093623.M6055@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.30.0101131735450.11391-200000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101131735450.11391-200000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Sat, Jan 13, 2001 at 05:37:01PM +0100
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Pungenday, the 13rd day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 05:37:01PM +0100, Igmar Palsenberg wrote:
> Hi,
> 
> kernel : 2.4.0 vanilla
> iproute2 version : ss001007
> 
> After building I've got a few problems :
> 
> ./ip rule list
> RTNETLINK answers: Invalid argument
> Dump terminated

You forgot to set CONFIG_IP_ADVANCED_ROUTER

> Version should be OK according to the Changes file.
> 
> config is attached
> 
> 
>         Regards,
> 		Igmar
-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
