Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271838AbRHUTHU>; Tue, 21 Aug 2001 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRHUTHM>; Tue, 21 Aug 2001 15:07:12 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:1257 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271826AbRHUTG4>; Tue, 21 Aug 2001 15:06:56 -0400
Message-ID: <3B82B136.1010904@korseby.net>
Date: Tue, 21 Aug 2001 21:06:30 +0200
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: cwidmer@iiic.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: massive filesystem corruption with 2.4.9
In-Reply-To: <E15ZEJM-0008Di-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Does memtest86 show up anything on this box ?

No errors...

Btw: As far as I know did the problem occur since I patched 2.4.5 with ac13 or 
ac15. Maybe a clean 2.4.5 works fine. I'm not sure about this. It's some time 
ago... Did you have made some important ext2-related changes with 2.4.5-ac?. I 
could revert to the old kernel and test him if it is relevant.

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

