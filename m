Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUEGAkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUEGAkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEGAkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:40:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:48282 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262279AbUEGAkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:40:11 -0400
Date: Fri, 7 May 2004 01:37:54 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Arjan van de Ven <arjanv@redhat.com>
cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
In-Reply-To: <1083858033.3844.6.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org>
References: <20040505013135.7689e38d.akpm@osdl.org>  <200405051312.30626.dominik.karall@gmx.net>
  <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> 
 <20040505215136.GA8070@wohnheim.fh-wedel.de>  <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
 <1083858033.3844.6.camel@laptop.fenrus.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Arjan van de Ven wrote:

> Ok I don't want to start a flamewar but... Do we want to hold linux
> back until all binary only module vendors have caught up ??

What about normal linux modules though? Eg, NFS (most likely):

	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121804

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Disraeli was pretty close: actually, there are Lies, Damn lies, Statistics,
Benchmarks, and Delivery dates.
