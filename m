Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWBCSiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWBCSiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWBCSiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:38:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64473 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030194AbWBCSiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:38:17 -0500
Date: Fri, 3 Feb 2006 13:36:56 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
In-Reply-To: <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0602031336080.11162@cuia.boston.redhat.com>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
 <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Linus Torvalds wrote:

> So I think at least 1/5 (and quite frankly, 2-3/5 look that way too) are 
> things that we can (and probably should) merge quickly, so that people 
> can then actually look at the differences in the places that they may 
> actually disagree about.

Agreed.  There are a lot of common bits between the various
virtualization solutions, if we can get those out of the way
it should be a lot easier to get the last bits done...

-- 
All Rights Reversed
