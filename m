Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSIWTwY>; Mon, 23 Sep 2002 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbSIWTwY>; Mon, 23 Sep 2002 15:52:24 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:8940 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S261421AbSIWTwX> convert rfc822-to-8bit; Mon, 23 Sep 2002 15:52:23 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Date: Mon, 23 Sep 2002 16:00:03 -0400
User-Agent: KMail/1.4.6
Cc: Andreas Dilger <adilger@clusterfs.com>, sct@redhat.com,
       Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
References: <200209182118.12701.spstarr@sh0n.net> <3D896F73.5D1265B5@digeo.com> <20020923200337.L11682@redhat.com>
In-Reply-To: <20020923200337.L11682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209231600.03978.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Which branch of the kernel is this going into? an -ac branch or 2.5 bk?

On September 23, 2002 03:03 pm, Stephen C. Tweedie wrote:
> Hi,
>
> On Wed, Sep 18, 2002 at 11:32:19PM -0700, Andrew Morton wrote:
> > I had a little patch.  Stephen is working on the big fix.
>
> It passed an overnight Cerberus at the end of last week.  :-)
> Checking into CVS shortly, then I need to set up a pile of recovery
> tests to make sure it's still writing everything it needs to in time.
>
> --Stephen

