Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUHYXPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUHYXPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUHYXM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:12:59 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:25542 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S266175AbUHYXJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:09:59 -0400
Message-ID: <412D1C18.2050709@ttnet.net.tr>
Date: Thu, 26 Aug 2004 02:09:12 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [3/4]
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo:
Initially some non-inline/non-gcc34 related backports
sneaked in the original patch and this was why I splitted
the patch up.
These hunk are, as they're labelled, fixes from 2.6 while
we are working on the intermezzo directory:  While hunting
for the many changes for the intermezzo inline fixes in
the other trees, I also caught these ones and thought that
you may be interested in them.
Feel free to apply or dump them.
Ozkan


On Mon, Aug 23, 2004 at 08:15:28PM +0300, O.Sezer wrote:
> splitted-up the fs/* gcc3.4-inline-patches.
>
> [3/4] intermezzo, while we're here
>
>

Ozkan,

What is this about?

I can't understand this as trivial gcc3.4 inline fixes.

