Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVI1AFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVI1AFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVI1AFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:05:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35998 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751134AbVI1AFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:05:34 -0400
Date: Tue, 27 Sep 2005 17:05:27 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] mm: page fault scalability prep
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0509271701290.11040@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Hugh Dickins wrote:

> Here comes the preparatory batch for my page fault scalability patches.
> This batch makes a few fixes - I suggest 01 and 02 should go in 2.6.14 -
> and a lot of tidyups, clearing some undergrowth for the real patches.

Well. A mind-boogling patchset. Cannot say that I understand all of it but 
this does a lot of mine sweeping through the troublespots that I 
also have seen. Great work!
