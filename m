Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314034AbSEAUTY>; Wed, 1 May 2002 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314035AbSEAUTX>; Wed, 1 May 2002 16:19:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33010
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314034AbSEAUTX>; Wed, 1 May 2002 16:19:23 -0400
Date: Wed, 1 May 2002 13:19:27 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guillaume Boissiere <boissiere@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  May 1, 2002
Message-ID: <20020501201927.GS574@matchmail.com>
Mail-Followup-To: Guillaume Boissiere <boissiere@attbi.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CCFBB21.9046.7889B0D2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 09:53:37AM -0400, Guillaume Boissiere wrote:
> new framebuffer layer, as well as some more delayed disk block 
> allocation bits.

Actually Andrews work on address_space based writeback is related somewhat,
but really it's a rewrite/cleanup of the buffer layer.  Delayed block
alocation is helped alot by this, and almost depends on it IIRC.

One vote for a seperate listing in the status for "Address Space based
Writeback / Buffer layer cleanup".
