Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272886AbRIGWk0>; Fri, 7 Sep 2001 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272877AbRIGWkQ>; Fri, 7 Sep 2001 18:40:16 -0400
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:26351 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272886AbRIGWkC>; Fri, 7 Sep 2001 18:40:02 -0400
Message-ID: <3B994BEC.F418F342@didntduck.org>
Date: Fri, 07 Sep 2001 18:36:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "SATHISH.J" <sathish.j@tatainfotech.com>
CC: kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reg lilo.conf changed and system doesn't boot
In-Reply-To: <Pine.LNX.4.10.10109072322550.30022-100000@blrmail>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"SATHISH.J" wrote:
> 
> Hi,
> I know that this is not the place to ask this question.Please forgive me.
> I changed the lilo.conf on my machine(redhat 2.2.14-12 kernel) and it
> doesn't boot up. I don't have
> a boot floppy to boot. I have another disk which has an older version of
> linux(2.2.6). I can mount the disk if I boot from the other
> disk(2.2.6). Can I
> in some way alter the lilo.conf of my disk(2.2.14) and boot linux from
> that. Please tell me any ideas to do that.

Boot your 2.2.6 disk, and make a boot floppy from that.  Put in the
original disk and boot from the floppy.  Check your lilo.conf and rerun
lilo.

-- 

						Brian Gerst
