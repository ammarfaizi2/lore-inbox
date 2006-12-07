Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937960AbWLGObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937960AbWLGObj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937961AbWLGObi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:31:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45478 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937960AbWLGObi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:31:38 -0500
Date: Thu, 7 Dec 2006 14:31:36 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061206154020.bdc0e09a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612071425380.31668@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
 <20061205100140.24888a96.akpm@osdl.org> <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
 <20061205114310.e85d4c7e.akpm@osdl.org> <Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
 <20061205122057.c2b617f4.akpm@osdl.org> <Pine.LNX.4.64.0612052131410.14114@pentafluge.infradead.org>
 <20061206154020.bdc0e09a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway, it seems all screwed up - I'll drop the patch.

I'm working on a new patch. The build system has changed quite a bit 
from the last time I worked with it 2 years ago.  
