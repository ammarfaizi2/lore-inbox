Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUEFEy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUEFEy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 00:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUEFEy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 00:54:58 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:13044 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261602AbUEFEy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 00:54:57 -0400
Date: Wed, 5 May 2004 21:54:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Buddy Lumpkin <b.lumpkin@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can hugepages or a similar option be used as the pagecache for an NFS server instance?
Message-ID: <20040506045455.GA20435@taniwha.stupidest.org>
References: <S261530AbUEFESd/20040506041833Z+648@vger.kernel.org> <S263093AbUEEGzR/20040505065517Z+175@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S261530AbUEFESd/20040506041833Z+648@vger.kernel.org> <S263093AbUEEGzR/20040505065517Z+175@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 12:01:45AM -0700, Buddy Lumpkin wrote:

> Is there a way currently to make a linux system running an NFS server
> instance store it's pagecache in 4mb pages?

Not presently.


On Wed, May 05, 2004 at 09:24:18PM -0700, Buddy Lumpkin wrote:

> Is there a way to increase the size of pages used for the pagecache?

Not presently.



  --cw

