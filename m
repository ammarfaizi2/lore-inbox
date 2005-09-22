Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVIVVct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVIVVct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVIVVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:32:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14751 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751168AbVIVVct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:32:49 -0400
Date: Thu, 22 Sep 2005 14:32:25 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
In-Reply-To: <43332161.20806@vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0509221431070.18664@schroedinger.engr.sgi.com>
References: <4329A6A3.7080506@vc.cvut.cz> <20050916023005.4146e499.akpm@osdl.org>
 <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org>
 <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
 <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
 <Pine.LNX.4.62.0509201800460.6792@schroedinger.engr.sgi.com>
 <4330B5C2.3080300@vc.cvut.cz> <Pine.LNX.4.62.0509210856410.10272@schroedinger.engr.sgi.com>
 <Pine.LNX.4.62.0509221250120.17975@schroedinger.engr.sgi.com>
 <20050922130150.0822b882.akpm@osdl.org> <43332161.20806@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Petr Vandrovec wrote:

> Sorry, I've missed that half of email completely.  Yes, it seems to fix
> problem,
> box has currently 8 min uptime, which is 7:55 more than it survived before.

I thought the box did not boot at all? The problem appears on an 
otherwise idle machine after bootup?
