Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSKRSvL>; Mon, 18 Nov 2002 13:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRSvL>; Mon, 18 Nov 2002 13:51:11 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23686 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262981AbSKRSvK>; Mon, 18 Nov 2002 13:51:10 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 10:58:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       <riel@surriel.com>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD936F4.EDA4968A@digeo.com>
Message-ID: <Pine.LNX.4.44.0211181057550.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Andrew Morton wrote:

> Here's Dave's profile.  ep_notify_file_close() makes a small appearance.
> The change you made to 2.5.48 will wipe that out.  Neat.

It was per-Linus suggestion actually :)



- Davide


