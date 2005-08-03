Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVHCOfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVHCOfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVHCOfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:35:16 -0400
Received: from ns1.suse.de ([195.135.220.2]:54698 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261651AbVHCOdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:33:16 -0400
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] GFS
References: <20050802071828.GA11217@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Aug 2005 16:33:08 +0200
In-Reply-To: <20050802071828.GA11217@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73slxrqee3.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> writes:

> Hi, GFS (Global File System) is a cluster file system that we'd like to
> see added to the kernel.  The 14 patches total about 900K so I won't send
> them to the list unless that's requested.  Comments and suggestions are
> welcome.  Thanks
> 
> http://redhat.com/~teigland/gfs2/20050801/gfs2-full.patch
> http://redhat.com/~teigland/gfs2/20050801/broken-out/

I would suggest to not merge this before not all the code has not been
reviewed by some experienced linux developer from outside the GFS team.

-Andi
