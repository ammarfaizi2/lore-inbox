Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbULPXJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbULPXJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbULPXJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:09:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262054AbULPXJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:09:01 -0500
Date: Thu, 16 Dec 2004 18:08:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Philip R Auld <pauld@egenera.com>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
In-Reply-To: <20041216220434.GC16621@vienna.egenera.com>
Message-ID: <Pine.LNX.4.61.0412161807400.26850@chimarrao.boston.redhat.com>
References: <20041216102652.6a5104d2.akpm@osdl.org> <E1Cf2k0-00069l-00@mta1.cl.cam.ac.uk>
 <20041216220434.GC16621@vienna.egenera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Philip R Auld wrote:

> The boot-time switch seems to be the ideal. This would allow
> enterprise Linux vendors to support using Xen w/o having to
> deal with a whole archicture release (including install kernel

I have no idea how such a boot-time switch would work
for 3rd party device drivers, though, so don't count
yourself lucky just yet ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
