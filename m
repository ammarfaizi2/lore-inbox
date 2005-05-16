Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVEPVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVEPVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEPVmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:42:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:50842 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261889AbVEPVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:41:18 -0400
Date: Mon, 16 May 2005 14:40:57 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 boot failure
In-Reply-To: <743780000.1116279381@flay>
Message-ID: <Pine.LNX.4.62.0505161439100.2927@schroedinger.engr.sgi.com>
References: <735450000.1116277481@flay> <20050516142504.696b443b.akpm@osdl.org>
 <743780000.1116279381@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Martin J. Bligh wrote:

> --On Monday, May 16, 2005 14:25:04 -0700 Andrew Morton <akpm@osdl.org> wrote:
> 
> > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >> 
> >> PPC64 NUMA box. Maybe this is the same NUMA slab problem you were 
> >> hitting before ...
> > 
> > Probably.  Christoph, this patch has crossed the grief threshold - I'll
> > drop it.
> 
> OK, fair enough. Christoph, I am interested in seeing your patch work 
> ... is something that's needed. If you want, I can help you offline 
> with some testing on a variety of platforms.

Some description of the failure would be helpful. A boot log? .config?

Does the box have CONFIG_NUMA off and CONFIG_DISCONTIG on?

