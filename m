Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280594AbRKJSvP>; Sat, 10 Nov 2001 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280603AbRKJSvF>; Sat, 10 Nov 2001 13:51:05 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:4228 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280594AbRKJSuz>;
	Sat, 10 Nov 2001 13:50:55 -0500
Message-ID: <3BED770A.D5D4BAA3@pobox.com>
Date: Sat, 10 Nov 2001 10:50:50 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
In-Reply-To: <3BECC7F4.A9EF9E6B@pobox.com>
		<Pine.LNX.4.33.0111101148250.20176-100000@sphinx.mythic-beasts.com> <20011110.053116.41632367.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> Just back out the netfilter changes in 2.4.15-pre1, that
> is the cause.

Great, will do - hopefully this will be backed
out of -pre3, or else sorted out properly...

cu

jjs


