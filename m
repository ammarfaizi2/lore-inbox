Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVETXmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVETXmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVETXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 19:42:55 -0400
Received: from graphe.net ([209.204.138.32]:60683 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261605AbVETXmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 19:42:54 -0400
Date: Fri, 20 May 2005 16:42:44 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <428E56EE.4050400@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505201640110.4740@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net>
 <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com>
 <Pine.LNX.4.62.0505201210460.390@graphe.net> <428E56EE.4050400@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Matthew Dobson wrote:

> > See patch above?
> 
> I can't for the life of me explain why, but the above patch makes ALL the
> warnings go away, despite the fact that they seem unrelated.  I dunno...
> Maybe we should upgrade the compiler on that box?

I better not comment on gcc 2.95 since I may say something that would 
not be so helpful...,.
