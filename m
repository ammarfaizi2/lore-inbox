Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263231AbTCYRvM>; Tue, 25 Mar 2003 12:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263236AbTCYRvM>; Tue, 25 Mar 2003 12:51:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41554 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263231AbTCYRvK>; Tue, 25 Mar 2003 12:51:10 -0500
Date: Tue, 25 Mar 2003 18:04:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: fix unuse_pmd() OOM handling
In-Reply-To: <20030325170139.GK1350@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0303251801530.10350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, William Lee Irwin III wrote:
> Fix unuse_pmd() OOM handling for pte_chain_alloc() failures.
> Unfortunately I'm not able to trigger anything more than light
> swapping loads to test this with.

Sorry, Bill: please ignore this one, Andrew: I'm preparing a
better patch for this, extracted from my anobjrmap patches.

Hugh

