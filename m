Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTJAXRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTJAXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:17:52 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:30558 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262651AbTJAXRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:17:50 -0400
Date: Wed, 1 Oct 2003 19:17:44 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: James Morris <jmorris@redhat.com>, <torvalds@osdl.org>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <vserver@solucorp.qc.ca>
Subject: Re: sys_vserver
In-Reply-To: <20031001161442.B14425@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0310011916260.4454-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Chris Wright wrote:
> * James Morris (jmorris@redhat.com) wrote:
> > I think virtualization is important/useful enough to warrant an API of
> > it's own.  It could be similar to LSM, e.g.  allow pluggable
> > virtualization modules, with no cost for the base kernel.
> 
> Doesn't sound like 2.6 material.

Maybe not, but it does sound like something we want to be
ready by the time 2.7 is forked ;)

Also, some parts of the virtualisation code might be 2.6
material after all, depending on how simple/complex the
code in question is.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

