Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAYWdW>; Thu, 25 Jan 2001 17:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRAYWdM>; Thu, 25 Jan 2001 17:33:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7437 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129143AbRAYWdD>; Thu, 25 Jan 2001 17:33:03 -0500
Message-ID: <3A70A989.EAEB7AF9@transmeta.com>
Date: Thu, 25 Jan 2001 14:32:41 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A709E99.25ADE5F6@echostar.com> <94q96s$9b2$1@cesium.transmeta.com> <20010125143127.F1659@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
> It occurs to me that it might be a good idea to pick a different port for
> these things.  I know a lot of people who want to use port 80h for
> debugging data, especially in embedded x86 systems.
> 

Find a safe port, make sure it is tested the hell out of, and we'll
consider it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
