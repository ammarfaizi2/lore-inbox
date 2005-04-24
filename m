Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVDXVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVDXVTo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVDXVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:19:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48833 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262433AbVDXVT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:19:28 -0400
Date: Sun, 24 Apr 2005 22:19:42 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPoRz-0000Y0-00@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> No.  You can't set "mount environment" in scp.

Of course you can.  It does execute the obvious set of rc files.
 
> Otherwise your analogy is nice, but misses a few points.  The usage of
> mounts that we are talking about is much more dynamic than usage of
> environment variables.

What the hell are you smoking and just how are you using shell?
