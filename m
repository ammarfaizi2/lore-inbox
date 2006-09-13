Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWIMVnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWIMVnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWIMVnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:43:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51654 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751205AbWIMVns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:43:48 -0400
Date: Wed, 13 Sep 2006 14:43:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18-rc6.mm2] revert migrate_move_mapping to use direct
 radix tree slot update
In-Reply-To: <1158183622.5328.61.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609131443190.19426@schroedinger.engr.sgi.com>
References: <1158174574.5328.37.camel@localhost> 
 <Pine.LNX.4.64.0609131344450.19101@schroedinger.engr.sgi.com>
 <1158183622.5328.61.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Lee Schermerhorn wrote:

> If you want to do it that way, I'll need to supply another patch to
> clean up the compiler warnings [I think they were just warnings]
> resulting from the change [at your suggestion ;-)] in the interface to
> the radix tree functions.  

That would be nice.

