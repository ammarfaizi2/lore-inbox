Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWDZJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWDZJhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWDZJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:37:10 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:15237 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751259AbWDZJhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:37:09 -0400
Date: Wed, 26 Apr 2006 11:36:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org, holzheu@de.ibm.com,
       minyard@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] strstrip API
Message-ID: <20060426093640.GA29108@wohnheim.fh-wedel.de>
References: <1145956265.27659.22.camel@localhost> <200604252235.25803.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604252235.25803.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 April 2006 22:35:24 +0200, Ingo Oeser wrote:
> On Tuesday, 25. April 2006 11:11, Pekka Enberg wrote:
> > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > 
> > This patch adds a new strstrip() function to lib/string.c for removing
> > leading and trailing whitespace from a string.
> > 
> > Cc: Michael Holzheu <holzheu@de.ibm.com>
> > Cc: Ingo Oeser <ioe-lkml@rameria.de>
> > Cc: Jörn Engel <joern@wohnheim.fh-wedel.de>
> > Cc: Corey Minyard <minyard@acm.org>
> > Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Acked-by: Ingo Oeser <ioe-lkml@rameria.de>
Acked-by: Joern Engel <joern@wh.fh-wedel.de>

> Simple enough and fits all users so far.
> Good work!

Agreed.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
