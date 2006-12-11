Return-Path: <linux-kernel-owner+w=401wt.eu-S937693AbWLKWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937693AbWLKWaA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937691AbWLKWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:30:00 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:57818 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937687AbWLKW37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:29:59 -0500
Date: Mon, 11 Dec 2006 14:26:36 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, kurt.hackel@oracle.com,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [RFC: -mm patch] OCFS2: make code static
Message-ID: <20061211222636.GC6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061211005807.f220b81c.akpm@osdl.org> <20061211191001.GF28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211191001.GF28443@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Dec 11, 2006 at 08:10:01PM +0100, Adrian Bunk wrote:
> On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc6-mm2:
> >...
> >  git-ocfs2.patch
> >...
> >  git trees.
> >...
> 
> This patch makes needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I hand-merged the tcp.c change as the patch introducing that variable is
going upstream soon. Would you mind sending me the dlm/* stuff as a seperate
patch?

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
