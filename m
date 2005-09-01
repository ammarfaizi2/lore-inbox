Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVIAOZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVIAOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVIAOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:25:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:41450 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965141AbVIAOZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:25:55 -0400
Subject: Re: GFS, what's remaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Teigland <teigland@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050901035939.435768f3.akpm@osdl.org>
References: <20050901104620.GA22482@redhat.com>
	 <20050901035939.435768f3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 15:49:18 +0100
Message-Id: <1125586158.15768.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 03:59 -0700, Andrew Morton wrote:
> - Why the kernel needs two clustered fileystems

So delete reiserfs4, FAT, VFAT, ext2, and all the other "junk". 

> - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
>   possibly gain (or vice versa)
> 
> - Relative merits of the two offerings

You missed the important one - people actively use it and have been for
some years. Same reason with have NTFS, HPFS, and all the others. On
that alone it makes sense to include.

Alan

