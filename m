Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTAETZx>; Sun, 5 Jan 2003 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAETZx>; Sun, 5 Jan 2003 14:25:53 -0500
Received: from holomorphy.com ([66.224.33.161]:11986 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265066AbTAETZw>;
	Sun, 5 Jan 2003 14:25:52 -0500
Date: Sun, 5 Jan 2003 11:34:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: jasonp@boo.net
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rewritten page coloring for 2.4.20 kernel
Message-ID: <20030105193411.GJ9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jasonp@boo.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <200301051603.LAA18650@boo-mda02.boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301051603.LAA18650@boo-mda02.boo.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, jasonp wrote:
>> Any chance for a 2.5.x-mm port? This is a bit feature-ish for 2.4.x.

On Sun, Jan 05, 2003 at 04:03:33PM +0000, jasonp@boo.net wrote:
> I know. The problem is that 2.5.53 cannot finish booting on the Alpha I have
> here (IDE issues). While I can port the patch over, I'm not comfortable being
> unable to test it at all.

What kind of Alpha? Got an oops/backtrace?

I probably can't reproduce it directly since my Alpha's diskless.


Bill
