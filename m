Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTAXHlc>; Fri, 24 Jan 2003 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTAXHlc>; Fri, 24 Jan 2003 02:41:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33418 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267588AbTAXHlb>;
	Fri, 24 Jan 2003 02:41:31 -0500
Date: Fri, 24 Jan 2003 08:50:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Olien <dmo@osdl.org>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, markw@osdl.org, cliffw@osdl.org,
       maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030124075030.GF910@suse.de>
References: <20030123135448.A8801@acpi.pdx.osdl.net> <20030123143824.4aae1efd.akpm@digeo.com> <20030123143453.A9072@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123143453.A9072@acpi.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Dave Olien wrote:
> 
> Yup, that should be 2.5.59-mm2.  My typo.
> 
> > > I've filed a bug on the OSDL bugme database.  You can read it at:
> > > 
> > > 	http://bugme.osdl.org/show_bug.cgi?id=288
> > 
> > The title is "2.5.59 and 2.5.50-mm2".  I assume it should be 2.5.59-mm2??
> 
> My test system's down right now.  As soon as it comes up, I'll
> get onto reproducing it there.

I'm assuming vanilla 2.5.59, there's no BUG_ON() in -mm5 that line.

-- 
Jens Axboe

