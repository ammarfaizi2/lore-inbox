Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUEGUpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUEGUpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUEGUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:38:04 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:41373 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263804AbUEGUfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:35:03 -0400
Date: Fri, 7 May 2004 20:48:40 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Arjan van de Ven <arjanv@redhat.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <Pine.LNX.4.58.0405072045170.1979@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.58.0405072047240.1979@fogarty.jakma.org>
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net>
 <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
 <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
 <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
 <20040507065105.GA10600@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0405072045170.1979@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Paul Jakma wrote:

> On Fri, 7 May 2004, Arjan van de Ven wrote:
> 
> > NFSv4 has a > 1Kb stack user; Dave Jones has a fix pending for
> > that...
> 
> I'm using NFSv3 though.

Well.. the mount itself is NFSv3 at least. The kernel does however
have NFSv4 client support and support for the rpc_pipefs fs.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Forgive and forget.
		-- Cervantes
