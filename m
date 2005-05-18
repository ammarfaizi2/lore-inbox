Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVERPRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVERPRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVERPQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:16:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12655 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262241AbVERPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:13:48 -0400
Date: Wed, 18 May 2005 16:14:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Timur Tabi <timur.tabi@ammasso.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
In-Reply-To: <428B58CF.4080604@ammasso.com>
Message-ID: <Pine.LNX.4.61.0505181604530.5145@goblin.wat.veritas.com>
References: <428B4D14.2030104@ammasso.com> 
    <Pine.LNX.4.61.0505181559340.5111@goblin.wat.veritas.com> 
    <428B58CF.4080604@ammasso.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 18 May 2005 15:13:40.0739 (UTC) 
    FILETIME=[2C6F2D30:01C55BBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Timur Tabi wrote:
> Hugh Dickins wrote:
> 
> > The first mainline version of Linux to incorporate it was 2.6.7-rc3
> > (SuSE, and the -mm tree, had it earlier).
> 
> How did you know that?

I know the patch because it went from Andrea to me to Andrew to Linus.

I have a copy of the 2.6.N trees here on my laptop so can quickly
verify my recollection that the first 2.6.N it appeared in was 2.6.7.

Then I searched through each ChangeLog-2.6.7-rcN at
http://ftp.kernel.org/pub/linux/kernel/v2.6/testing/
for comments on get_user_pages.

Hugh
