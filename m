Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVBBWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVBBWEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVBBWEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:04:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58582 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262814AbVBBWEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:04:20 -0500
Date: Wed, 2 Feb 2005 14:03:51 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, mel@csn.ul.ie,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] Helping prezoring with reduced fragmentation allocation
In-Reply-To: <20050202121922.1251c677.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502021403180.14275@schroedinger.engr.sgi.com>
References: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
 <Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0502011929020.16992@skynet> <Pine.LNX.4.58.0502011604130.5406@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0502020026040.16992@skynet> <20050202164936.GA23718@logos.cnet>
 <20050202121922.1251c677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Andrew Morton wrote:

> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> >  What are your thoughts about inclusion of Mel's allocator work on -mm ?
>
> It's sitting in my to-do pile.

Tell me when you need my prezeroing patches on top of mel's patches....

