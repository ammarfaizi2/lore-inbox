Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUD2Cps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUD2Cps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUD2Cpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:45:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:38836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbUD2Cn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:43:59 -0400
Date: Wed, 28 Apr 2004 19:43:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428194308.598d078b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404282240590.19633-100000@chimarrao.boston.redhat.com>
References: <20040428185720.07a3da4d.akpm@osdl.org>
	<Pine.LNX.4.44.0404282240590.19633-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Wed, 28 Apr 2004, Andrew Morton wrote:
> > Rik van Riel <riel@redhat.com> wrote:
> > >
> > >  IMHO, the VM on a desktop system really should be optimised to
> > >  have the best interactive behaviour, meaning decent latency
> > >  when switching applications.
> > 
> > I'm gonna stick my fingers in my ears and sing "la la la" until people tell
> > me "I set swappiness to zero and it didn't do what I wanted it to do".
> 
> Agreed, you shouldn't be the one to fix this problem.
> 

What problem?
