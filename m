Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTKGFw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 00:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTKGFwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 00:52:25 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:8878 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263900AbTKGFwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 00:52:25 -0500
Date: Fri, 7 Nov 2003 16:52:14 +1100
From: Nathan Scott <nathans@sgi.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Maciej Zenczykowski <maze@cela.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
Message-ID: <20031107055214.GJ782@frodo>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl> <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi> <20031107050037.GI782@frodo> <Pine.LNX.4.58.0311070715230.10194@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311070715230.10194@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 07:43:13AM +0200, Szakacsits Szabolcs wrote:
> 
> I know xfs_copy (it's my preferred fs in the last 6+ years) but the last
> time I checked it (before I sent my earlier email) it couldn't copy only
> metadata as e2image (always) and ntfsclone (optionally) can do:

You are correct (I should read the whole thread before piping up!),
thats on my ToDo list now - would be a very handy developers tool.

cheers.

-- 
Nathan
