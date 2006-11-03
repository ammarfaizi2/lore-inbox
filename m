Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753117AbWKCFOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbWKCFOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 00:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbWKCFOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 00:14:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41364 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753117AbWKCFOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 00:14:19 -0500
Date: Thu, 2 Nov 2006 21:13:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
In-Reply-To: <20061103144243.4601ba76.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0611022112290.12449@schroedinger.engr.sgi.com>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Stephen Rothwell wrote:

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Christoph Lameter <clameter@sgi.com>
