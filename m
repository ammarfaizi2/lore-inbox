Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUKPBsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUKPBsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUKPBsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:48:02 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35845 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261746AbUKPBsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:48:00 -0500
Date: Tue, 16 Nov 2004 01:47:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <20041115155311.64ae2150.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58L.0411160142340.12776@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
 <4198EFE5.5010003@aknet.ru> <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl>
 <20041115155311.64ae2150.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Andrew Morton wrote:

> Don't be pissed off - please send a patch which puts in whatever debugging
> you think we need to have to be able to properly support the APIC code.

 OK, I'll have a look at it.  Lots of these messages are real crap and
hardly useful anymore now that the code works pretty well, but some bits
that are more dependent on hardware quirks rather than code quality are 
still worth being output unconditionally at some reasonable loglevel.

  Maciej
