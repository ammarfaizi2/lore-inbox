Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTH3KAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTH3KAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:00:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40972 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261642AbTH3KAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:00:02 -0400
Date: Sat, 30 Aug 2003 11:53:30 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac1
Message-ID: <20030830095330.GM734@alpha.home.local>
References: <200308291237.h7TCbYc12849@devserv.devel.redhat.com> <20030830090223.GC27477@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830090223.GC27477@charite.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 11:02:23AM +0200, Ralf Hildebrandt wrote:
> * Alan Cox <alan@redhat.com>:
> 
> > Linux 2.4.22-ac1
> 
> Did you forget to adjust the version string in the patch? It reports
> as bk2 here.

are you sure you didn't apply it on top of -bk2 yourself ? In this case, you
should get at least a Makefile.rej because an empty EXTRAVERSION was expected.

Willy

