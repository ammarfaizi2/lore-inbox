Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUF0NU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUF0NU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUF0NU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:20:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbUF0NUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:20:55 -0400
Date: Sun, 27 Jun 2004 09:20:50 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 rh9 thrashing unreasonably
In-Reply-To: <200406271134.42853@WOLK>
Message-ID: <Pine.LNX.4.44.0406270919130.3889-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Marc-Christian Petersen wrote:
> On Sunday 27 June 2004 05:27, Dan Kegel wrote:
> 
> > Any suggestions on tuning the existing kernel before I pitch it?
> 
> use a non-RH kernel.

Or a Fedora Legacy kernel.  The RHL9 product hasn't been
supported by Red Hat since april, currently the Fedora
Legacy people are taking care of the older distributions.

	http://www.fedoralegacy.org/

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

