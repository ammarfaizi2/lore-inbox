Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbUKTBc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUKTBc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbUKTBav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:30:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22974 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263082AbUKTB34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:29:56 -0500
Date: Fri, 19 Nov 2004 17:29:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hugh Dickins <hugh@veritas.com>
cc: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [1/7]: sloppy rss
In-Reply-To: <Pine.LNX.4.44.0411192045500.6940-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411191729240.1719@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411192045500.6940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10-rc2-bk3

On Fri, 19 Nov 2004, Hugh Dickins wrote:

> Sorry, against what tree do these patches apply?
> Apparently not linux-2.6.9, nor latest -bk, nor -mm?
