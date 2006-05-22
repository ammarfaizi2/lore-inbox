Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWEVS2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWEVS2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWEVS2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:28:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:27855 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750849AbWEVS2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:28:49 -0400
From: Andi Kleen <ak@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: [RFC] Consoldidate arch/{i386,x86_64}/boot
Date: Mon, 22 May 2006 20:28:32 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4471FD34.8050202@gmx.net>
In-Reply-To: <4471FD34.8050202@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605222028.32934.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would a series of incremental patches to consolidate these two
> subtrees get accepted?

Yes.

I have some plans to change the 64bit boot up though - the uncompression
should already run as 64bit - but that shouldnt' affect these files.

-Andi

