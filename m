Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268387AbTAMWfv>; Mon, 13 Jan 2003 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTAMWfu>; Mon, 13 Jan 2003 17:35:50 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:62469 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268387AbTAMWeC>; Mon, 13 Jan 2003 17:34:02 -0500
Date: Mon, 13 Jan 2003 22:42:51 +0000
From: John Levon <levon@movementarian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jens Axboe <axboe@suse.de>, Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113224251.GB72391@compsoc.man.ac.uk>
References: <20030113184831.GC14017@suse.de> <7857.1042496092@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7857.1042496092@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18YDIB-000Eql-00*XoxUe/iuElA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 09:14:52AM +1100, Keith Owens wrote:

> >But still requiring up-apic, or smp with apic, right?
> 
> nmi_watchdog=2 - uses performance counters, not apic.

which requires a local APIC to set up NMI delivery mode like Jens said

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
