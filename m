Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUJXRpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUJXRpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUJXRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:45:21 -0400
Received: from clusterfw.beelinegprs.net ([217.118.66.232]:16684 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S261561AbUJXRpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:45:15 -0400
Date: Sun, 24 Oct 2004 21:42:27 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: marcel@hilzinger.hu, reiser@namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com
Subject: Re: =?koi8-r?Q?=9A2=2E6=2E9-mm1?=
Message-ID: <20041024174227.GA15746@backtop.namesys.com>
References: <20041022032039.730eb226.akpm@osdl.org> <4179425A.3080903@namesys.com> <1078.217.232.234.250.1098558101.squirrel@florka.hu> <20041023123957.35cfc389.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023123957.35cfc389.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 23, 2004 at 12:39:57PM -0700, Andrew Morton wrote:
> "Hilzinger Marcel" <marcel@hilzinger.hu> wrote:
> >
> > SuSE Linux 9.2 will contain reiser4
> 
> hm.  Nobody ever tells me anything.  Does that mean that
> SuSE are using 8k stacks?

We have several reiser4/4KSTACKS successful reports.  However, enabling reiser4
debugging and, probably, using reiser4 over dmapper, make things less stable.

-- 
Alex.
