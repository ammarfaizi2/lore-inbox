Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTKGFAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 00:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTKGFAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 00:00:49 -0500
Received: from zok.sgi.com ([204.94.215.101]:6596 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263883AbTKGFAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 00:00:48 -0500
Date: Fri, 7 Nov 2003 16:00:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Maciej Zenczykowski <maze@cela.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
Message-ID: <20031107050037.GI782@frodo>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl> <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 06:35:03AM +0200, Szakacsits Szabolcs wrote:
> On Thu, 6 Nov 2003, Maciej Zenczykowski wrote:
> 
> > So anything like e2image available for reiserfs?
> 
> AFAIK, no for other filesystems (saving only metadata), only for NTFS
> (e2image gave the inspiration):

SEE ALSO
xfs_copy(8).


cheers.

-- 
Nathan
