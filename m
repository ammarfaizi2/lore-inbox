Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbVKRIoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbVKRIoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKRIoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:44:16 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:54477 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030559AbVKRIoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:44:15 -0500
Date: Fri, 18 Nov 2005 00:43:59 -0800
From: Paul Jackson <pj@sgi.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, sct@redhat.com, dhowells@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <20051118004359.3e69626b.pj@sgi.com>
In-Reply-To: <4204.1132255682@warthog.cambridge.redhat.com>
References: <20051116035639.3eaa7a35.akpm@osdl.org>
	<20051115112504.4b645a86.akpm@osdl.org>
	<20051114150347.1188499e.akpm@osdl.org>
	<dhowells1132005277@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
	<11717.1132077542@warthog.cambridge.redhat.com>
	<1932.1132140406@warthog.cambridge.redhat.com>
	<4204.1132255682@warthog.cambridge.redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> > Maybe on the fourth or fifth time it'll occur you to put it into the
> > changelog.
> 
> But that's not what's changed.

Just a guess - perhaps the following clarifies this point of confusion:

The "changelog" isn't so much for what you've changed, relative to the
previous version of that patch.  It is for what will go into the Linux
change history for this patch, when accepted.

To quote Documentation/SubmittingPatches, which calls this the
"explanation body":

    The explanation body will be committed to the permanent source
    changelog, so should make sense to a competent reader who has long
    since forgotten the immediate details of the discussion that might
    have led to this patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
