Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTJAVow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbTJAVow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:44:52 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48354 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262587AbTJAVov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:44:51 -0400
Date: Wed, 1 Oct 2003 17:44:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: torvalds@osdl.org, <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <vserver@solucorp.qc.ca>
Subject: Re: sys_vserver
In-Reply-To: <20031001141654.N14398@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0310011744030.19538-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Chris Wright wrote:

> I believe a reasonable portion of vserver can become a security module,
> but there would clearly remain a need for some of the virtualization
> (e.g. hostname, etc.).

I definately want to have as much as possible of vserver
using the normal security infrastructure, simply because
it will save the vserver maintainers a lot of work ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

