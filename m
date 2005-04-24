Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVDXUyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVDXUyL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVDXUyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:54:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36028 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262417AbVDXUyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:54:09 -0400
Date: Sun, 24 Apr 2005 21:54:22 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPo3I-0000V0-00@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:50:04PM +0200, Miklos Szeredi wrote:
> Also mentioned in that thread quite a few times is the fact the the
> clone() and unshare() modell does not solve people's requirements.

Could we please get of references to requirements without a rationale?
There's quite enough of that from Carrion-Grade Linux crowd, TYVM.
