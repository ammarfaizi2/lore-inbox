Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287574AbRLaRYo>; Mon, 31 Dec 2001 12:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287575AbRLaRYc>; Mon, 31 Dec 2001 12:24:32 -0500
Received: from h00e02954cece.ne.mediaone.net ([24.91.228.68]:17792 "EHLO
	gonzo.amherst.genlogic.com") by vger.kernel.org with ESMTP
	id <S287574AbRLaRYT>; Mon, 31 Dec 2001 12:24:19 -0500
Message-ID: <3C309F51.9050908@mediaone.net>
Date: Mon, 31 Dec 2001 12:24:33 -0500
From: Sam Krasnik <genlogic@mediaone.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel lockup?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*please cc the replies to me*

hello

i have been getting some (i thought) kernel lockups. only a hard reset would
help. originally i thought it was the emu10k1 sb live driver, and i read
that 2.4.7 didn't have the problem (i was using 2.4.8). i also tried using
alsa, which didn't work either.

however, after seeing it still happening, i am led to believe that it may
be some power management problem or not a kernel problem at all...
(in which case this mailing list is NOT where i should be posting,
sorry for the distraction if i am wrong). the lockup only happens after
extended periods of idle time (specifically in the morning after a night
of not using the computer). the sysrq works, so i guess it isn't a hard
lockup? if it is kernel...what then? if not...what could be the problem?


thx

--sam

