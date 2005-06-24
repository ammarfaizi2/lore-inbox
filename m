Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVFXD3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVFXD3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVFXD3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:29:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263034AbVFXD1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:27:08 -0400
Date: Thu, 23 Jun 2005 20:29:06 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: jmorris@redhat.com, mark.fasheh@oracle.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       torvalds@osdl.org, akpm@osdl.org, wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
Message-Id: <20050623202906.39c8ec8a.pj@sgi.com>
In-Reply-To: <20050623200524.298a6ab4.pj@sgi.com>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
	<Xine.LNX.4.44.0506231358230.14123-100000@thoron.boston.redhat.com>
	<20050623200524.298a6ab4.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple more random questions:

 1) How does this lock manager relate to the Red Hat lock manager,
    the dlm-* patches?

    Note as an aside that dlm-* has 23 patches for a total of 14
    thousand lines, or about 600 lines per patch.  This is rather
    different than burying a lock manager into a 45 thousand line
    new file system patch ;)

 2) Would a diffstat be a useful addition to this patch?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
