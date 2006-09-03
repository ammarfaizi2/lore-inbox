Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWICEU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWICEU4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 00:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWICEU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 00:20:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752023AbWICEU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 00:20:56 -0400
Date: Sat, 2 Sep 2006 21:20:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES
 too low!
Message-Id: <20060902212043.030d8032.akpm@osdl.org>
In-Reply-To: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
References: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006 20:03:46 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> Sorry Andrew.  I don't see clues here to help me target the report to
> a maintainer.
> I hope this helps.
> 
> BUG: MAX_STACK_TRACE_ENTRIES too low!

That would be an Ingo thing, but he's having a bit of downtime.

-- 
VGER BF report: H 0.298568
