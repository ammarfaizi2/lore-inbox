Return-Path: <linux-kernel-owner+w=401wt.eu-S932189AbXAOKZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXAOKZo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbXAOKZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:25:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbXAOKZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:25:43 -0500
Subject: Re: [-mm patch] make gfs2_change_nlink_i() static
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
In-Reply-To: <20070113095640.GK7469@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <20070113095640.GK7469@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 15 Jan 2007 10:31:19 +0000
Message-Id: <1168857079.11844.62.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2007-01-13 at 10:56 +0100, Adrian Bunk wrote:
> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.20-rc3-mm1:
> >...
> >  git-gfs2-nmw.patch
> >...
> >  git trees
> >...
> 
> 
> This patch makes the needlessly globlal gfs2_change_nlink_i() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
Now applied to the GFS2 -nme git tree. Thanks,

Steve.


