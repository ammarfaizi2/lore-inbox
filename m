Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281806AbRLGO5x>; Fri, 7 Dec 2001 09:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGO5V>; Fri, 7 Dec 2001 09:57:21 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:59147 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S281794AbRLGO4c>; Fri, 7 Dec 2001 09:56:32 -0500
Subject: Re: 2.5.1pre6 compile error
From: "Martin A. Brooks" <martin@jtrix.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011207145206.GH12017@suse.de>
In-Reply-To: <1007722213.24166.2.camel@unhygienix> 
	<20011207145206.GH12017@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 07 Dec 2001 14:55:42 +0000
Message-Id: <1007736943.24166.25.camel@unhygienix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 14:52, Jens Axboe wrote:
> Please take a look at the rq->cmd -> rq->flags changes. Then understand
> them. Then fix ps2 and send me a diff, thanks.

As I may have mentioned before, I'm no kernel hacker, I'm just a chimp
with a compiler :)

-- 
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com

