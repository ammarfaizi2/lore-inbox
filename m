Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbTCXDiO>; Sun, 23 Mar 2003 22:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbTCXDiN>; Sun, 23 Mar 2003 22:38:13 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:42770 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262883AbTCXDiN>; Sun, 23 Mar 2003 22:38:13 -0500
Date: Sun, 23 Mar 2003 22:49:03 -0500
From: Ben Collins <bcollins@debian.org>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring back Al's devfs changes in dv1394
Message-ID: <20030324034903.GL29859@phunnypharm.org>
References: <20030322183926.A21623@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322183926.A21623@lst.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 06:39:26PM +0100, Christoph Hellwig wrote:
> needed to get the only callder of devfs_mk_dir where the first argument
> is not NULL back in shape.  Also a nice code cleanup..

Applied to SVN trunk. I'll push to Linus tomorrow.


Thanks

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
