Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAWShB>; Tue, 23 Jan 2001 13:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbRAWSgx>; Tue, 23 Jan 2001 13:36:53 -0500
Received: from raven.toyota.com ([63.87.74.200]:30478 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129846AbRAWSgk>;
	Tue, 23 Jan 2001 13:36:40 -0500
Message-ID: <3A6DCF36.CF93E926@toyota.com>
Date: Tue, 23 Jan 2001 10:36:38 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Venner <jason@vennerable.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)  (win98 not honoring partitioning)
In-Reply-To: <200101231813.KAA24039@echo.vennerable.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Venner wrote:

> Windows 98 and possibly followons doesn't quite honor 'b' type
> partitions in the extended area of the disk, particularily if you are
> past the 8gig boundary and the partitions in question are over 2gig.
> The above numbers are NOT hard boundaries, I have only seen this on 2
> computers and those numbers are approximate.

This should be an FAQ - running windows on a system
where you have a Linux partition is dangerous, and you
run the risk of losing all your data. Any Linux system that
contains important data should NOT dual boot with windows.

The voice of experience talking...

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
