Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129451AbQKHSTC>; Wed, 8 Nov 2000 13:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbQKHSSx>; Wed, 8 Nov 2000 13:18:53 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:11791 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129689AbQKHSSj>;
	Wed, 8 Nov 2000 13:18:39 -0500
Date: Wed, 8 Nov 2000 10:18:54 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011081856460.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.21.0011081017320.2704-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure - but this was always the case. And using 2.2 with the same
> (or more) stress the Xserver is still able to set the video hardware
> back to vga text mode. I just want to know whats the difference
> between 2.2 and 2.4 that causes failure in 2.4.

I don't think it is the console system. I bet if you stress 2.2 even more
you will get the same results.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
