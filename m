Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268736AbUHZLfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbUHZLfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUHZLfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:35:02 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:955 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268652AbUHZLTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:19:55 -0400
Date: Thu, 26 Aug 2004 04:19:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: helge.hafting@hist.no, riel@redhat.com, mikulas@artax.karlin.mff.cuni.cz,
       torvalds@osdl.org, hch@lst.de, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826041944.567b0589.pj@sgi.com>
In-Reply-To: <20040826104713.GA30449@mail.shareable.org>
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
	<412D968B.9030107@hist.no>
	<20040826022137.1504ffb7.pj@sgi.com>
	<20040826104713.GA30449@mail.shareable.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Too late.  We have xattrs already; many programs don't store them.

If by your "too late" you mean we can stop worrying about any more
breakage of file system utilities, because there exists an example
in which some were already broken, then you are absolutely wrong.

Just because we caused some breakage doesn't give us license to cause
even more.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
