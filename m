Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbULSCPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbULSCPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 21:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbULSCPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 21:15:22 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:51133 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261261AbULSCPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 21:15:17 -0500
Message-ID: <41C4E430.4090807@yahoo.com.au>
Date: Sun, 19 Dec 2004 13:15:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm26 arch and include updates
References: <41C2559C.2010209@f2s.com> <41C493A2.30703@f2s.com>
In-Reply-To: <41C493A2.30703@f2s.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> Any takers? I know I dont get a massive amount of time to work on this 
> but it would be nice to keep what I have in sync with the tree when 
> others make global changes.

Not that I'm qualified to comment about the architecture at all.

But it sounds like it is an improvement over what is currently in
there. Seeing as you're listed as ARM26 maintainer, and the patch
being completely contained to arm26, I'm sure you could get it
included quite easily ;)

The patch isn't _that_ big, but if you broke it up into a series, and
posted them (inline) to lkml, I'm sure Andrew Morton would queue them
up for after 2.6.10 for you (make sure he sees them).

Or alternatively, if it is accompanied by a quite detailed changelog,
often these sort of updates can be taken in as a single patch.

Good luck!

Nick
