Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRABDN2>; Mon, 1 Jan 2001 22:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRABDNT>; Mon, 1 Jan 2001 22:13:19 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:54997 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129780AbRABDNE>; Mon, 1 Jan 2001 22:13:04 -0500
Date: Mon, 1 Jan 2001 21:42:36 -0500
From: Tom Vier <thomassr@erols.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 compile error for 2.4.0-prerelease
Message-ID: <20010101214236.A15497@zero>
In-Reply-To: <3A513089.9AF6EB6A@teatime.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A513089.9AF6EB6A@teatime.com.tw>; from tommy@teatime.com.tw on Tue, Jan 02, 2001 at 09:36:09AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same on alpha

On Tue, Jan 02, 2001 at 09:36:09AM +0800, Tommy Wu wrote:
> panic.c: In function `panic':
> panic.c:80: `loops_per_sec' undeclared (first use in this function)
> panic.c:80: (Each undeclared identifier is reported only once
> panic.c:80: for each function it appears in.)

-- 
Tom Vier <thomassr@erols.com>
DSA Key id 0x27371A2C
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
