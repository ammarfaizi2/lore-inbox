Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSGAPzp>; Mon, 1 Jul 2002 11:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSGAPzo>; Mon, 1 Jul 2002 11:55:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51727 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315631AbSGAPzn>; Mon, 1 Jul 2002 11:55:43 -0400
Date: Mon, 1 Jul 2002 11:52:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
In-Reply-To: <200207011604.58253.roy@karlsbakk.net>
Message-ID: <Pine.LNX.3.96.1020701115130.23428A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:

> still - sorry if this is OT - I'm just too close to tear my hair or head off 
> or something
> 
> The documentation everywhere, including the lilo 22.3.1 sample conf ffile 
> tells me "use boot = /dev/md0", but lilo, when run, just tells me 
> 
> Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0

I saw something like that when someone had made a raid device by hand and
used hda and hdb instead of hda1 and hdb1.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

