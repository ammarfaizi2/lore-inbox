Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbQLPU73>; Sat, 16 Dec 2000 15:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbQLPU7U>; Sat, 16 Dec 2000 15:59:20 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:57802 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131878AbQLPU7B>; Sat, 16 Dec 2000 15:59:01 -0500
Date: Sat, 16 Dec 2000 15:28:33 -0500
From: Tom Vier <thomassr@erols.com>
To: Chad Schwartz <cwslist@main.cornernet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping chars on 16550
Message-ID: <20001216152833.A7536@zero>
In-Reply-To: <Pine.LNX.4.21.0012141529580.2159-100000@server.serve.me.nl> <Pine.LNX.4.30.0012140833520.14206-100000@main.cornernet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.30.0012140833520.14206-100000@main.cornernet.com>; from cwslist@main.cornernet.com on Thu, Dec 14, 2000 at 08:51:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 08:51:42AM -0600, Chad Schwartz wrote:
> And what kind of serial ports do you find on your Alpha?  16550's!  Your
> PowerPC?  16550's!  Your PA-RISC box? 16550's!  Hey! Even RS/6000's use
> 16550's!

macs and sun machines use z85c30 chips, so there are some non-16550 boxes
out there.

-- 
Tom Vier <thomassr@erols.com>
DSA Key id 0x27371A2C
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
