Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbSIWUR2>; Mon, 23 Sep 2002 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSIWUR2>; Mon, 23 Sep 2002 16:17:28 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:6278 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261357AbSIWUR1>; Mon, 23 Sep 2002 16:17:27 -0400
Date: Mon, 23 Sep 2002 21:22:22 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Message-ID: <20020923212222.S11682@redhat.com>
References: <200209182118.12701.spstarr@sh0n.net> <3D896F73.5D1265B5@digeo.com> <20020923200337.L11682@redhat.com> <200209231600.03978.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209231600.03978.spstarr@sh0n.net>; from spstarr@sh0n.net on Mon, Sep 23, 2002 at 04:00:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 23, 2002 at 04:00:03PM -0400, Shawn Starr wrote:
 
> Which branch of the kernel is this going into? an -ac branch or 2.5 bk?

Ext3 CVS, but I'll also make a clean, broken-down patchset for
2.4.19 bk. 

In fact, the only reason it's not in ext3 cvs already is because it's
such a pain keeping discrete broken-down patches separate using a form
of SCM like bk or cvs; having decent scripts to track multiple patches
in a working source tree just works a lot better for one developer
when it comes to merging stuff upstream.

Cheers,
 Stephen
