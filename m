Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQLEEvY>; Mon, 4 Dec 2000 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbQLEEvJ>; Mon, 4 Dec 2000 23:51:09 -0500
Received: from [198.167.161.1] ([198.167.161.1]:20603 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S131150AbQLEEus>;
	Mon, 4 Dec 2000 23:50:48 -0500
Message-ID: <3A2C6CEB.DC56C960@isn.net>
Date: Tue, 05 Dec 2000 00:19:55 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4 drivers/net/dummy
In-Reply-To: <Pine.LNX.4.30.0012040937470.14256-200000@viper.haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you send it Linus?
It is not in pre5
	Garst
"Mohammad A. Haque" wrote:

> Ok, so here's the proper patch for those who dont want to wait for t5 =)
> Ignore previous.
> 
> On Mon, 4 Dec 2000, Jeff Garzik wrote:
> 
> > the fix is in module.h which needs extra parens in the def of
> > set_module_owner...
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
