Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUEWGFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUEWGFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 02:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUEWGFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 02:05:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262339AbUEWGFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 02:05:15 -0400
Date: Sun, 23 May 2004 07:05:14 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: consistent ioctl for getting all net interfaces?
Message-ID: <20040523060514.GX17014@parcelfarce.linux.theplanet.co.uk>
References: <pan.2004.05.23.04.28.28.143054@triplehelix.org> <20040523053538.GW17014@parcelfarce.linux.theplanet.co.uk> <20040523055759.GG25346@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523055759.GG25346@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 10:57:59PM -0700, Joshua Kwan wrote:
> On Sun, May 23, 2004 at 06:35:38AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > ASCII is tough, let's go shopping?
> > [snip code i already have]
> 
> I always found parsing files in C ugly, but I guess I have no choice
> then.

I would argue that ioctl() is inherently ugly, regardless of the language
used to call it.  _And_ ioctl-based variant will actually take more code.

> Thanks anyway.
