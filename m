Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTFXXhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 19:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFXXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 19:37:09 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:41609 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263418AbTFXXhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 19:37:02 -0400
From: jlnance@unity.ncsu.edu
Date: Tue, 24 Jun 2003 19:50:49 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.72: follow_mount / follow_link
Message-ID: <20030624235049.GA9292@ncsu.edu>
References: <3EF86337.1020103@sun.com> <20030624145418.GP6754@parcelfarce.linux.theplanet.co.uk> <bd9ri0$fn2$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9ri0$fn2$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 08:42:56AM -0700, H. Peter Anvin wrote:

> Unfortunately, this is probably the only realistic way to ever get
> working direct mounts, so please don't dismiss it out of hand.
> follow_link on a directory has turned out to be a really useful way of
> doing automounting.

Hi Peter,
    I have always wondered why direct mounts, as well as things like
/net/host are difficult with Linux.  If you have a couple of minutes,
would you explain the problem?  Also, do you have any idea how Solaris
does this and is it easier there?

Thanks,

Jim
