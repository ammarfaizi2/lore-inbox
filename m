Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275007AbTHFXsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275017AbTHFXr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:47:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30737
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275007AbTHFXrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:47:08 -0400
Date: Wed, 6 Aug 2003 16:47:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Timothy Miller <miller@techsource.com>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-ID: <20030806234704.GI21290@matchmail.com>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org> <3F310B6D.6010608@namesys.com> <3F319146.6080607@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F319146.6080607@techsource.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 07:37:42PM -0400, Timothy Miller wrote:
> 
> 
> Hans Reiser wrote:
> 
> >reiser4 cpu consumption is still dropping rapidly as others and I find 
> >kruft in the code and remove it.  Major kruft remains still.

> Now, if you can manage to make it twice as fast while NOT increasing the 
> CPU usage, well, then that's brilliant, but the fact that ReiserFS uses 
> more CPU doesn't bother me in the least.

Basically he's saying it's faster and still not at its peak effeciency yet
too.
