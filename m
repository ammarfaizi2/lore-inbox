Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUEQQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUEQQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUEQQ2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:28:04 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:53966 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261875AbUEQQ2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:28:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 17 May 2004 09:28:01 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: "Theodore Ts'o" <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       elenstev@mesatop.com, lm@bitmover.com,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page?
In-Reply-To: <Pine.LNX.4.58.0405170919590.19557@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405170927160.19557@bigblue.dev.mdolabs.com>
References: <200405162136.24441.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org>
 <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org>
 <Pine.LNX.4.58.0405170919590.19557@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004, Davide Libenzi wrote:

> Strange, it uses read/write but it also opens an mmap(private and 
> anonymous):

That is not file related (I should have had breakfast before posting :)



- Davide

