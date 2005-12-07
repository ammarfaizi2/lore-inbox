Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbVLGS1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbVLGS1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbVLGS1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:27:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13267 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751018AbVLGS1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:27:15 -0500
Date: Wed, 7 Dec 2005 10:27:00 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
In-Reply-To: <439684C0.9090107@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0512071026360.24516@schroedinger.engr.sgi.com>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
 <439619F9.4030905@yahoo.com.au> <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com>
 <439684C0.9090107@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Nick Piggin wrote:

> Sorry, I think I meant: why don't you just use the "add all counters
> from all per-cpu of the node" in order to find the node-statistic?

which function is that?
