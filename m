Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTH3PDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 11:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTH3PDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 11:03:17 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:34983 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264696AbTH3PDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 11:03:12 -0400
Date: Sat, 30 Aug 2003 17:03:05 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac1
Message-ID: <20030830150305.GD6862@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200308291237.h7TCbYc12849@devserv.devel.redhat.com> <20030830090223.GC27477@charite.de> <20030830095330.GM734@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830095330.GM734@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau <willy@w.ods.org>:
> On Sat, Aug 30, 2003 at 11:02:23AM +0200, Ralf Hildebrandt wrote:
> > * Alan Cox <alan@redhat.com>:
> > 
> > > Linux 2.4.22-ac1
> > 
> > Did you forget to adjust the version string in the patch? It reports
> > as bk2 here.
> 
> are you sure you didn't apply it on top of -bk2 yourself ? In this case, you
> should get at least a Makefile.rej because an empty EXTRAVERSION was expected.

I'm rebuilding as we speak. I shouldn't be patching & building kernels
while talking to my wife.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
