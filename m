Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288297AbSACU3f>; Thu, 3 Jan 2002 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288301AbSACU3Z>; Thu, 3 Jan 2002 15:29:25 -0500
Received: from ns.suse.de ([213.95.15.193]:37384 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288297AbSACU3K>;
	Thu, 3 Jan 2002 15:29:10 -0500
Date: Thu, 3 Jan 2002 21:29:09 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Keith Owens <kaos@ocs.com.au>,
        Mike Castle <dalgoda@ix.netcom.com>, <linux-kernel@vger.kernel.org>
Subject: Re: State of the new config & build system
In-Reply-To: <20020103104605.A37@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0201032128090.12592-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Pavel Machek wrote:

> Being able to cp -a then build without full rebuild is good. Also make dep
> takes  *long* and and bad things happen when you think it was not needed ;-).

And being able to NFS share 1 kernel tree, and be able to do parallel
builds on multiple boxes without having to wait until 1 is finished.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

