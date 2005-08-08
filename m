Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVHHVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVHHVYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHHVYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:24:15 -0400
Received: from smtp.istop.com ([66.11.167.126]:31975 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932265AbVHHVYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:24:15 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Tue, 9 Aug 2005 07:24:30 +1000
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de>
In-Reply-To: <200508090710.00637.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508090724.30962.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Scuse me:

On Tuesday 09 August 2005 07:09, Daniel Phillips wrote:
> Suggestion for your next act:

...kill PG_checked please :)  Or at least keep it from spreading.

Regards,

Daniel
