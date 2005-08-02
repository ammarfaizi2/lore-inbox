Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVHBHOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVHBHOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVHBHOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:14:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261347AbVHBHNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:13:23 -0400
Date: Tue, 2 Aug 2005 15:18:28 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: [PATCH 00/14] GFS
Message-ID: <20050802071828.GA11217@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, GFS (Global File System) is a cluster file system that we'd like to
see added to the kernel.  The 14 patches total about 900K so I won't send
them to the list unless that's requested.  Comments and suggestions are
welcome.  Thanks

http://redhat.com/~teigland/gfs2/20050801/gfs2-full.patch
http://redhat.com/~teigland/gfs2/20050801/broken-out/

Dave

