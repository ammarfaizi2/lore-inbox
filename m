Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131036AbQKHBBy>; Tue, 7 Nov 2000 20:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131094AbQKHBBo>; Tue, 7 Nov 2000 20:01:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:48903 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131036AbQKHBBf>; Tue, 7 Nov 2000 20:01:35 -0500
Message-ID: <3A08A454.A1174EEE@timpanogas.org>
Date: Tue, 07 Nov 2000 17:54:44 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: kernel@kvack.org, Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <E13tJY0-00080Y-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > I'll grab the code in linux and port.
> 
> You are welcome
> 
> Make sure you get a pretty current 2.2.x tree however. The ultra deep magic
> for detecting NexGen processors is recent. It took a long time before I found
> someone who knew how it worked 8)

I'll get on it.  Alan, if ELF can do this now, it would be good idea to
do this with the mutiple images.  Sounds like it's just a link option
and a few more smarts in the lilo and boot loader to make it work.

8)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
