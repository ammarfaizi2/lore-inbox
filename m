Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKMWw4>; Mon, 13 Nov 2000 17:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKMWwq>; Mon, 13 Nov 2000 17:52:46 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:3332 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S129061AbQKMWwg>;
	Mon, 13 Nov 2000 17:52:36 -0500
Message-ID: <3A106A88.571AFF9E@windeath.2y.net>
Date: Mon, 13 Nov 2000 16:26:16 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: twaugh@redhat.com, tytso@mit.edu, wollny@cns.mpg.de
Subject: Re:test11-pre1 Parport/IMM/Zip Oops fixed -- Are we in Florida?
In-Reply-To: <3A088352.BCAD0B7A@windeath.2y.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James M wrote:
> 
>    My previously reported Parport/Zip Oops seems to have gone away. I
> suspect the SMP race fixs were the culprit...thank you.
>    However my parport is still misdetected as SPP by the IMM driver when
> it is actually set to EPP. This is an Epox/SMP Xeon (400 mhz), EP-GXB-M
> with an Award Bios and Winbond Super I/O Multi controller.

Move that one back into the broken column please. It happened between
11pre2 and 11pre3.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
