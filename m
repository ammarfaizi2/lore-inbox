Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUD2CmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUD2CmM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUD2CmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:42:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262972AbUD2CmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:42:07 -0400
Date: Wed, 28 Apr 2004 22:41:19 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: brettspamacct@fastclick.com, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040428185720.07a3da4d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404282240590.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
> >
> >  IMHO, the VM on a desktop system really should be optimised to
> >  have the best interactive behaviour, meaning decent latency
> >  when switching applications.
> 
> I'm gonna stick my fingers in my ears and sing "la la la" until people tell
> me "I set swappiness to zero and it didn't do what I wanted it to do".

Agreed, you shouldn't be the one to fix this problem.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

