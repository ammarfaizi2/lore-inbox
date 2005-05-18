Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVERPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVERPEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVERPCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:02:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52835 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262274AbVERPAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:00:21 -0400
Date: Wed, 18 May 2005 16:00:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
In-Reply-To: <428B4D14.2030104@ammasso.com>
Message-ID: <Pine.LNX.4.61.0505181559340.5111@goblin.wat.veritas.com>
References: <428B4D14.2030104@ammasso.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 18 May 2005 15:00:12.0435 (UTC) 
    FILETIME=[4AA5C630:01C55BBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Timur Tabi wrote:

> Given a particular file and a particular bitkeeper revision for the file, how
> can I tell which version of the kernel incorporated that changeset?

Someone else might answer that.

> In particular, I want to know about revision 1.65 of mm/rmap.c, which can be
> seen at
> http://linux.bkbits.net:8080/linux-2.6/diffs/mm/rmap.c@1.65?nav=index.html|src/|src/mm|hist/mm/rmap.c
> 
> I want to know what the first version of Linux is to incorporate that change.

The first mainline version of Linux to incorporate it was 2.6.7-rc3
(SuSE, and the -mm tree, had it earlier).

Hugh
