Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267055AbRGIMs5>; Mon, 9 Jul 2001 08:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267056AbRGIMsr>; Mon, 9 Jul 2001 08:48:47 -0400
Received: from mail9.bigmailbox.com ([209.132.220.40]:33287 "EHLO
	mail9.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S267055AbRGIMsj>; Mon, 9 Jul 2001 08:48:39 -0400
Date: Mon, 9 Jul 2001 05:48:34 -0700
Message-Id: <200107091248.FAA12273@mail9.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.38.191]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: linux-kernel@vger.kernel.org
Cc: ketil@froyn.com
Subject: RE: 0k shared?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ketil,

> As you can see, there is no shared memory here. Is this something I > ought to worry about, or is it normal? I've been using the system, 
> and since things were lagging, I looked at 'top', and this just 
> caught my eye.
> Any reason for worry?
>
> And if you *really* want me to, I can see if I can reproduce this, 
> though I'd rather not. :-)
>

Hate to say this, but RTFFAQ.  On the linux-kernel FAQ (I forget the address), it mentions that in kernel 2.4.x, it became too hard to compute sharedmem, so they just left it blank... 8-)

     -- Colin


On the first day, man created the computer.  On the second day, God proclaimed from the heavens, "F0 0F C7 C8".

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
