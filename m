Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRAHTVn>; Mon, 8 Jan 2001 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAHTV0>; Mon, 8 Jan 2001 14:21:26 -0500
Received: from [63.95.87.168] ([63.95.87.168]:51716 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131139AbRAHTVM>;
	Mon, 8 Jan 2001 14:21:12 -0500
Date: Mon, 8 Jan 2001 14:21:10 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Steven_Snyder@3com.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
Message-ID: <20010108142110.C28287@xi.linuxpower.cx>
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>; from Steven_Snyder@3com.com on Mon, Jan 08, 2001 at 01:11:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:11:19PM -0600, Steven_Snyder@3com.com wrote:
[snip]
> No complaints are seen at startup, yet I still have no shared memory:
> 
>      # cat /proc/meminfo
>              total:    used:    free:  shared: buffers:  cached:
>      Mem:  130293760 123133952  7159808        0 30371840 15179776
>      Swap: 136241152        0 136241152
[snip]

The shared field is currently unused in 2.4.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
