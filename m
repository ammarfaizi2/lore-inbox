Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSI3WET>; Mon, 30 Sep 2002 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSI3WET>; Mon, 30 Sep 2002 18:04:19 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:1290 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261349AbSI3WES>;
	Mon, 30 Sep 2002 18:04:18 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020927091040.B1715@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet>
	<20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet>
	<20020926133725.A8851@ucw.cz> <1033054211.587.6.camel@chevrolet>
	<20020926185717.B27676@ucw.cz> <1033080648.593.12.camel@chevrolet> 
	<20020927091040.B1715@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Oct 2002 00:10:06 +0200
Message-Id: <1033423806.584.3.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2002-09-27 kl. 09:10 skrev Vojtech Pavlik:
> Unfortunately the little bit of information I needed scrolled away
> already. Can you try with the other shift (right?)? That won't
> probably crash your machine, but will most likely generate an "Unknown
> scancode" message. Again, send me the log lines. This time they should
> make it in the syslog well.
I guess this didn't help you either. But this night I got a bright idea,
or so I think, atleast. I'm actually using a KVM-switch, which I
ofcourse should have told you earlier, but it wasn't in my mind at all.
When not using the KVM switch, I get this message: 

input: AT Set 2 keyboard on isa0060/serio0
atkbd.c: Unknown key (set 2, scancode 0x1c9, on isa0060/serio0) pressed.

Will this help?

Thanks.

Best regards,
Stian Jordet

