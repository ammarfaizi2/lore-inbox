Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbULPXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbULPXNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbULPXNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:13:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38371 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262064AbULPXJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:09:53 -0500
Date: Thu, 16 Dec 2004 18:09:34 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Pavel Machek <pavel@suse.cz>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
In-Reply-To: <41C20FFF.6000004@tmr.com>
Message-ID: <Pine.LNX.4.61.0412161808450.26850@chimarrao.boston.redhat.com>
References: <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk><E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
 <20041215114916.GB1232@elf.ucw.cz> <41C20FFF.6000004@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Bill Davidsen wrote:

> Assuming this is practical and would let xen get exposure sooner rather 
> than later, it would be nice if the hooks could be used for other 
> projects.

> Who knows what operating systems might run in this way.

NetBSD and Plan 9 already run on Xen 2.0.  IIRC FreeBSD and
one of the other BSDs are being ported, too...


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
