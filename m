Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUHTQE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUHTQE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUHTQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:04:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267397AbUHTQE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:04:56 -0400
Date: Fri, 20 Aug 2004 12:04:51 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Alan Cox <alan@redhat.com>
cc: Oliver Neukum <oliver@neukum.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       <arjanv@redhat.com>, <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <sct@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
In-Reply-To: <20040820150257.GC6812@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0408201204300.10373-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Alan Cox wrote:

> PF_MEMALLOC won't recurse. You might run out of memory however.

> Are any of the VM guys considering PF_LOGALLOC so you can trace it down 8)

No, but this thread does make me consider PF_NOIO ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

