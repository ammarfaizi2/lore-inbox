Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbTGHVKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbTGHVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:10:42 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:12048 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S267678AbTGHVKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:10:40 -0400
Date: Tue, 8 Jul 2003 16:25:17 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030708212517.GO1030@dbz.icequake.net>
References: <20030708202819.GM1030@dbz.icequake.net> <3F0B2CE6.8060805@nni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F0B2CE6.8060805@nni.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tue, Jul 08, 2003 at 04:43:18PM -0400, jhigdon wrote:
> 
> Have you tried this on any 2.5.x kernels? Just curious to see what it 
> does, I plan on giving it a go later.

I haven't, but a previous poster indicated that they had (2.5.74) with
the same results.

I wonder if we could find an upper limit on the number of allowable
processes that would leave the box in a workable state?  Unfortunately,
I don't have a spare box to test such things on at the moment. ;)

Thanks,
-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
