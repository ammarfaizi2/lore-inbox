Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTAIDQx>; Wed, 8 Jan 2003 22:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAIDQx>; Wed, 8 Jan 2003 22:16:53 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:15367 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261523AbTAIDQw>; Wed, 8 Jan 2003 22:16:52 -0500
Date: Thu, 9 Jan 2003 03:25:34 +0000
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] OProfile Pentium IV support
Message-ID: <20030109032534.GA67781@compsoc.man.ac.uk>
References: <20030109000035.GA53798@compsoc.man.ac.uk> <3E1CEA70.CE486C4D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1CEA70.CE486C4D@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WTK2-00095S-00*dKfgXBUYL0o*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 07:20:16PM -0800, Andrew Morton wrote:

> Below is a fix to make the kernel build when it is configured for
> something other than a p4.

Thanks.

> > http://www.movement.uklinux.net/oprofile-0.5cvs.tar.gz
> 
> $./configure

You need --with-kernel-support as usual. I'll  fix it not to be so
stupid

regards
john
