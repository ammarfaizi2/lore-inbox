Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTLAOIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTLAOIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:08:49 -0500
Received: from intra.cyclades.com ([64.186.161.6]:60386 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262888AbTLAOIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:08:47 -0500
Date: Mon, 1 Dec 2003 12:06:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: XFS for 2.4
In-Reply-To: <20031201062052.GA2022@frodo>
Message-ID: <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Dec 2003, Nathan Scott wrote:

> Hi Marcelo,
> 
> Please do a
> 
> 	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> 
> This will merge the core 2.4 kernel changes required for supporting
> the XFS filesystem, as listed below.  If this all looks acceptable,
> then please also pull the filesystem-specific code (fs/xfs/*)
> 
> 	bk pull http://xfs.org:8090/linux-2.4+justXFS

Nathan, 

I think XFS should be a 2.6 only feature.

2.6 is already stable enough for people to use it. 


