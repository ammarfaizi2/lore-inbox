Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTIVV27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbTIVV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:28:59 -0400
Received: from waste.org ([209.173.204.2]:51416 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261161AbTIVV26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:28:58 -0400
Date: Mon, 22 Sep 2003 16:28:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rjwalsh@durables.org, wangdi@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kgdb-over-ethernet using netpoll api
Message-ID: <20030922212853.GR2414@waste.org>
References: <20030922184738.GM2414@waste.org> <20030922135456.74890771.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922135456.74890771.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:54:56PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  l-mpm/include/asm/kgdb.h                  |   11 
> 
> Please don't generate diffs against `include/asm/foo.h': things tend to
> turn rather ugly when the symlink doesn't exist, or points at a different
> architecture's include directory...

Sorry, didn't think of that. Would you like a new copy? 

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
