Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129325AbQKXOwz>; Fri, 24 Nov 2000 09:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129231AbQKXOwq>; Fri, 24 Nov 2000 09:52:46 -0500
Received: from draconic.fyremoon.net ([194.159.247.49]:35599 "EHLO
        draconic.fyremoon.net") by vger.kernel.org with ESMTP
        id <S129145AbQKXOw3>; Fri, 24 Nov 2000 09:52:29 -0500
Message-ID: <60916.195.11.55.51.975075740.squirrel@www.fyremoon.net>
Date: Fri, 24 Nov 2000 14:22:20 -0000 (GMT)
Subject: Re: About IP address
From: "John Crowhurst" <FyreMoon@fyremoon.net>
To: coredumping@hotmail.com
In-Reply-To: <F198IZv0R1Cm7yvgffu00003ac1@hotmail.com>
In-Reply-To: <F198IZv0R1Cm7yvgffu00003ac1@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: FyreMoon@fyremoon.net
X-Mailer: SquirrelMail (version 1.0pre1 (cvs))
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, Class B address range is 128.1.0.0 ~ 191.254.0.0
> 
> Why 128.0.0.0 and 191.255.0.0 can't use ?
> 
> I can't understand it

This is because its the network and broadcast addresses of a Class A address
range. Simple answer :)

-- 
FyreMoon
Under the moon, the dragon flies.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
