Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTAFG37>; Mon, 6 Jan 2003 01:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbTAFG37>; Mon, 6 Jan 2003 01:29:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:46560 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266175AbTAFG36>; Mon, 6 Jan 2003 01:29:58 -0500
Date: Sun, 05 Jan 2003 22:38:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Timer interrupt cleanups [0/3]
Message-ID: <237880000.1041835109@titus>
In-Reply-To: <194400000.1041820329@titus>
References: <194400000.1041820329@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Original calling graph looked like this, I'll update this for
> each patch to show what happens. Feel free to flame me, everyone.

I'll flame myself instead ... these have some global vs arch code
hierarchy problems ... ignore them for now. I'll fix them tommorow.

M

