Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135362AbRAKWur>; Thu, 11 Jan 2001 17:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131833AbRAKWu1>; Thu, 11 Jan 2001 17:50:27 -0500
Received: from 24-216-78-5.hsacorp.net ([24.216.78.5]:54025 "EHLO
	mccoy.penguinpowered.com") by vger.kernel.org with ESMTP
	id <S130330AbRAKWuU>; Thu, 11 Jan 2001 17:50:20 -0500
From: Jens Petersohn <jkp@mccoy.penguinpowered.com>
Message-Id: <200101112248.QAA07735@mccoy.penguinpowered.com>
Subject: Re: Ingo's RAID patch for 2.2.18 final?
To: taki@enternet.hu (Takacs Sandor)
Date: Thu, 11 Jan 2001 16:48:53 -0600 (CST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jkp@mccoy.penguinpowered.com (Jens Petersohn),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101112336240.10955-100000@mail.enternet.hu> from "Takacs Sandor" at Jan 11, 2001 11:42:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 11 Jan 2001, Alan Cox wrote:
> 
> > > I tried to apply it. If I finish it I will send the patch to mingo :)
> > 
> > try http://www.linuxraid.org/
> 
> If I see it there is no raid patch for 2.2.18 final, only
> 2.2.18pre13. This patch (raid-2.2.18-A2) rejects some diffs. I will apply
> it by hand :)
> 
> -- 
> Takika

Check lower on the page. There is a patch for the patch to bring it up
to A3. This resulting patch will apply semi-cleanly (with fuzz) to the
final kernel.

--Jens Petersohn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
