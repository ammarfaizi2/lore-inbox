Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVHIPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVHIPSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVHIPSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:18:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58086 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964817AbVHIPSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:18:13 -0400
Date: Tue, 9 Aug 2005 16:20:45 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk>
References: <20050802071828.GA11217@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802071828.GA11217@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 03:18:28PM +0800, David Teigland wrote:
> Hi, GFS (Global File System) is a cluster file system that we'd like to
> see added to the kernel.  The 14 patches total about 900K so I won't send
> them to the list unless that's requested.  Comments and suggestions are
> welcome.  Thanks
> 
> http://redhat.com/~teigland/gfs2/20050801/gfs2-full.patch
> http://redhat.com/~teigland/gfs2/20050801/broken-out/

Kindly lose the "Context Dependent Pathname" crap.
