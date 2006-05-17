Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWEQBj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWEQBj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEQBj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:39:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:11430 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751080AbWEQBj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:39:57 -0400
Date: Tue, 16 May 2006 18:36:28 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [-mm patch] fs/ocfs2/dlm/: cleanups
Message-ID: <20060517013628.GR21588@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060515005637.00b54560.akpm@osdl.org> <20060516152641.GA5677@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516152641.GA5677@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, May 16, 2006 at 05:26:41PM +0200, Adrian Bunk wrote:
> This patch #if 0's the no longer used dlm_dump_lock_resources().
> 
> Since this makes dlmdebug.h empty, this patch also removes this header.
> 
> Additionally, the needlessly global dlm_is_node_recovered() is made 
> static.
Yeah, that all looks good - thanks for the patch!
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
