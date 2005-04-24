Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVDXVkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVDXVkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVDXVkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:40:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:7336 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262445AbVDXVkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:40:00 -0400
Date: Sun, 24 Apr 2005 22:39:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424213949.GC9304@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPofK-0000Yu-00@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> > > No.  You can't set "mount environment" in scp.
> > 
> > Of course you can.  It does execute the obvious set of rc files.
> 
> Don't think so.  ftp server and sftp server sure as hell don't.

That's no argument, because you are free to change the ftp and sftp
servers to add this behaviour if you want it.

-- Jamie
