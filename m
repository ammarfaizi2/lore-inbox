Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbTCZS3I>; Wed, 26 Mar 2003 13:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbTCZS3I>; Wed, 26 Mar 2003 13:29:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:49216 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261853AbTCZS3I>; Wed, 26 Mar 2003 13:29:08 -0500
Date: Wed, 26 Mar 2003 18:42:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Bill Davidsen <davidsen@tmr.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <Pine.LNX.3.96.1030326130415.8110A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0303261841070.1439-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Bill Davidsen wrote:
> 
> Unless there's a subtle difference in functionality here that I'm missing,
> you are doing the same thing in a larger and slower way, and the logic is
> less clear.
> 
> Is there some benefit I'm missing?

No, it's just that Andrew finds the logic clearer when written out his way.

Hugh

