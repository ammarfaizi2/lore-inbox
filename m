Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVDKWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVDKWNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVDKWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:13:30 -0400
Received: from nevyn.them.org ([66.93.172.17]:54922 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261954AbVDKWN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:13:26 -0400
Date: Mon, 11 Apr 2005 18:13:24 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411221324.GA10541@nevyn.them.org>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 09:56:29PM +0200, Miklos Szeredi wrote:
> Well the sanity check on the "server" side is always enforced.  You
> can't "trick" sftp or ftp to not check permissions.  So checking on
> the "client" side too (where the fuse daemon is running) makes no
> sense, does it?

That argument doesn't make much sense to me.  But we're at the end of
my useful contributions to this discussion; I'm going to be quiet now
and hope some folks who know more about filesystems have more useful
responses.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
