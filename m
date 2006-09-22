Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWIVOZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWIVOZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWIVOZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:25:46 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:33691 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932529AbWIVOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:25:45 -0400
Date: Fri, 22 Sep 2006 16:25:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, evil@g-house.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] AFS: Manage AFS modularity vs FS-Cache modularity
Message-ID: <20060922142523.GB3767@wohnheim.fh-wedel.de>
References: <20060922123105.GA3767@wohnheim.fh-wedel.de> <20060922111137.16615.7794.stgit@warthog.cambridge.redhat.com> <20060922111140.16615.46012.stgit@warthog.cambridge.redhat.com> <20773.1158934671@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20773.1158934671@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 September 2006 15:17:51 +0100, David Howells wrote:
> 
> Well, AFS_FS is itself marked as being experimental, so I'm not sure that the
> AFS_FSCACHE option needs to be also.

Good point.  The other typo should be fairly obvious, though.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
