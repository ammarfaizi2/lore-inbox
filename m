Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQJZQfe>; Thu, 26 Oct 2000 12:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129676AbQJZQfY>; Thu, 26 Oct 2000 12:35:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:3957 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129423AbQJZQfS>; Thu, 26 Oct 2000 12:35:18 -0400
Date: Thu, 26 Oct 2000 19:35:08 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: saw@saw.sw.com.sg
Subject: eepro100: card reports no resources [was VM-global...]
Message-ID: <20001026193508.A19131@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Pfeiffer <profmakx@profmakx.de> wrote:
> 
> > Oct 26 11:24:13 ns29 kernel: eth0: card reports no resources.
> > Oct 26 11:24:15 ns29 kernel: eth0: card reports no resources.
> > Oct 26 12:22:21 ns29 kernel: eth0: card reports no resources.
> > Oct 26 16:16:59 ns29 kernel: eth0: card reports no resources.
> > Oct 26 16:28:37 ns29 kernel: eth0: card reports no resources.
> > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > 
> let me guess: intel eepro100 or similar??
> Well known problem with that one. dont know if its fully fixed ... With

Happens here too, with 2xPPro200, 2.2.18pre17, Eepro100 and light load.
The network stalls for several minutes when it happens.

> 2.4.0-test9-pre3 it doesnt happen on my machine ...

What about a fix for a 2.2.x...?


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
