Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSJIM1z>; Wed, 9 Oct 2002 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261671AbSJIM1z>; Wed, 9 Oct 2002 08:27:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23056 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261669AbSJIM1y>;
	Wed, 9 Oct 2002 08:27:54 -0400
Date: Wed, 9 Oct 2002 13:33:37 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Second round of ioctl cleanups
Message-ID: <20021009133337.Y18545@parcelfarce.linux.theplanet.co.uk>
References: <20021008000948.O18545@parcelfarce.linux.theplanet.co.uk> <20021008.212052.61268086.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008.212052.61268086.davem@redhat.com>; from davem@redhat.com on Tue, Oct 08, 2002 at 09:20:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:20:52PM -0700, David S. Miller wrote:
> This patch is ok _except_ you cannot remove contribution credits
> at the top of a file just because you deleted the whole of what
> they had fixed in the past.
> 
> Please redo this patch without those changes, thanks.

would it be ok to move these credits to net/socket.c?  it shows false
positives when grepping otherwise.

-- 
Revolutions do not require corporate support.
