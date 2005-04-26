Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVDZQoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVDZQoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVDZQl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:41:28 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:63364 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261513AbVDZQh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:37:56 -0400
Date: Tue, 26 Apr 2005 12:37:40 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [2.6 patch] fs/nfsd/: possible cleanups
Message-ID: <20050426163740.GA26367@fieldses.org>
References: <20050423000755.GN4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423000755.GN4355@stusta.de>
User-Agent: Mutt/1.5.9i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 02:07:55AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global function:
>   - nfs4state.c: set_no_grace

Got it, thanks.--b.
