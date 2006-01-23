Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWAWVC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWAWVC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWAWVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:02:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54225 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964875AbWAWVC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:02:57 -0500
Date: Mon, 23 Jan 2006 13:02:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: VM_ZONE_RECLAIM_MODE warning in kernel/sysctl.c
In-Reply-To: <Pine.LNX.4.61.0601232035450.6596@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0601231302340.32502@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0601232035450.6596@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Hugh Dickins wrote:

> Heed NUMA VM_ZONE_RECLAIM_MODE compiler warning in kernel/sysctl.c.

This is already fixed in Andrews tree.

