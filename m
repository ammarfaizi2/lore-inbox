Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSIWTBP>; Mon, 23 Sep 2002 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSIWTBM>; Mon, 23 Sep 2002 15:01:12 -0400
Received: from pc-80-195-34-180-ed.blueyonder.co.uk ([80.195.34.180]:6533 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261367AbSIWS6q>; Mon, 23 Sep 2002 14:58:46 -0400
Date: Mon, 23 Sep 2002 20:03:37 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Shawn Starr <spstarr@sh0n.net>,
       sct@redhat.com, Con Kolivas <conman@kolivas.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Message-ID: <20020923200337.L11682@redhat.com>
References: <200209182118.12701.spstarr@sh0n.net> <200209182140.30364.spstarr@sh0n.net> <1032403983.3d893c0f8986b@kolivas.net> <200209190016.26609.spstarr@sh0n.net> <20020919061301.GB13929@clusterfs.com> <3D896F73.5D1265B5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D896F73.5D1265B5@digeo.com>; from akpm@digeo.com on Wed, Sep 18, 2002 at 11:32:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 18, 2002 at 11:32:19PM -0700, Andrew Morton wrote:

> I had a little patch.  Stephen is working on the big fix.

It passed an overnight Cerberus at the end of last week.  :-)
Checking into CVS shortly, then I need to set up a pile of recovery
tests to make sure it's still writing everything it needs to in time.

--Stephen
