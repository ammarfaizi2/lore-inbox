Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbULQXRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbULQXRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbULQXRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:17:05 -0500
Received: from almesberger.net ([63.105.73.238]:12553 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262225AbULQXRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:17:02 -0500
Date: Fri, 17 Dec 2004 20:16:44 -0300
From: Werner Almesberger <werner@almesberger.net>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] prio_tree: move general code from mm/ to lib/
Message-ID: <20041217201644.F31842@almesberger.net>
References: <20041217154018.C21393@almesberger.net> <20041217153602.D31842@almesberger.net> <20041217154018.C21393@almesberger.net> <3700.1103325015@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3700.1103325015@redhat.com>; from dhowells@redhat.com on Fri, Dec 17, 2004 at 11:10:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The prio_tree stuff can go back in for the nommu stuff. I've given Andrew a
> patch to that effect (copied to LKML).

Ah, found it. Great, so there should be no conflict anymore.

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
