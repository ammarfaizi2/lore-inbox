Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTJEClE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTJEClE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:41:04 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:26854 "EHLO fep3.cogeco.net")
	by vger.kernel.org with ESMTP id S262948AbTJEClC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:41:02 -0400
Date: Sat, 4 Oct 2003 22:41:02 -0400
From: Scott West <swest3@cogeco.ca>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: cs4281 driver missing from 2.6.0-test6-bk6?
Message-Id: <20031004224102.64ff35c6.swest3@cogeco.ca>
In-Reply-To: <20031005012438.GG4274@digitasaru.net>
References: <20031005012438.GG4274@digitasaru.net>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003 20:24:39 -0500 Joseph Pingenot
<trelane@digitasaru.net> wrote:

> Hello.
> 
> I was using menuconfig to check out 2.6.0-test6-bk6, when I found that
>   the cs4281 ALSA driver had disappeared.
> Is this intentional, did I screw something up, or is it accidental?
> 
> Thanks!
> 
> -Joseph
> -- 
> Joseph===============================================trelane@digitasaru.net
> "Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
>  patents against open source projects, Mundie replied, 'Yes, absolutely.'
>  An audience member pointed out that many open source projects aren't
>  funded and so can't afford legal representation to rival Microsoft's. 'Oh
>  well,' said Mundie. 'Get your money, and let's go to court.' 
> Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Enabling joystick support under the input devices clears this up I believe. Sent me for a loop when I saw that too :).

Scott
