Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVFXEBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVFXEBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbVFXEBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:01:43 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:23868 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S263074AbVFXEAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:00:35 -0400
Date: Thu, 23 Jun 2005 20:59:40 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Paul Jackson <pj@sgi.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       torvalds@osdl.org, akpm@osdl.org, wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050624035940.GE8215@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com> <20050623200524.298a6ab4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623200524.298a6ab4.pj@sgi.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 08:05:24PM -0700, Paul Jackson wrote:
> These combine to make a 45 thousand line patch.  That's a big patch.
> Only the netdev and reiser4 patches (and the combined linus.patch)
> are bigger.
> 
> Shouldn't these be 3 patches, or more?
They are. I believe you're looking at the combined patch. If you want them
broken out, we keep those at
http://oss.oracle.com/projects/ocfs2/files/patches/

My original patch mail also had links to the broken out ones...
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

