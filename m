Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTAWWZt>; Thu, 23 Jan 2003 17:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTAWWZt>; Thu, 23 Jan 2003 17:25:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:62692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267365AbTAWWZs>;
	Thu, 23 Jan 2003 17:25:48 -0500
Date: Thu, 23 Jan 2003 14:34:53 -0800
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, markw@osdl.org,
       cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030123143453.A9072@acpi.pdx.osdl.net>
References: <20030123135448.A8801@acpi.pdx.osdl.net> <20030123143824.4aae1efd.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030123143824.4aae1efd.akpm@digeo.com>; from akpm@digeo.com on Thu, Jan 23, 2003 at 02:38:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yup, that should be 2.5.59-mm2.  My typo.

> > I've filed a bug on the OSDL bugme database.  You can read it at:
> > 
> > 	http://bugme.osdl.org/show_bug.cgi?id=288
> 
> The title is "2.5.59 and 2.5.50-mm2".  I assume it should be 2.5.59-mm2??

My test system's down right now.  As soon as it comes up, I'll
get onto reproducing it there.
