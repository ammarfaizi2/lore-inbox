Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUATSup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUATSup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:50:45 -0500
Received: from poup.poupinou.org ([195.101.94.96]:15404 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S265652AbUATSun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:50:43 -0500
Date: Tue, 20 Jan 2004 19:50:01 +0100
To: Dave Jones <davej@redhat.com>, Jens David <dg1kjd@afthd.tu-darmstadt.de>,
       hpa@zytor.com, linux-kernel@vger.kernel.org
Cc: ducrot@poupinou.org
Subject: Re: [PATCH] powernow-k7 settling time
Message-ID: <20040120185001.GB29844@poupinou.org>
References: <200401132239.i0DMddeK027814@mailserver2.hrz.tu-darmstadt.de> <20040113230904.GN14674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113230904.GN14674@redhat.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:09:04PM +0000, Dave Jones wrote:
> On Tue, Jan 13, 2004 at 11:39:39PM +0100, Jens David wrote:
> 
>  > Patch against linux-2.4.24-0pre2.1mdk from current Mandrake Cooker.
>  > Should apply cleanly to powernow-patched vanilla-2.4.x as well. Probably
>  > relevant for Linux-2.6, too.
> 
> 2.6 fixed this a few months back, in a different way.
> (The code misinterpreted the spec back then, so we were doing
>  all sorts of sillyness).
> 
> If Mandrake are still running the old version of the driver in their
> update kernel, you might want to bug them about it, as there have been
> numerous updates since then fixing lots of bugs.
> 

It's fixed in the CVS repo for linux-2.4 tree at the same time as for 2.6.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
