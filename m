Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132289AbRA2PeW>; Mon, 29 Jan 2001 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132638AbRA2PeC>; Mon, 29 Jan 2001 10:34:02 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:24592 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S132289AbRA2Pdx>;
	Mon, 29 Jan 2001 10:33:53 -0500
Subject: Re: Is HP Colorado 8Gb supported by Linux?
From: Richard Torkar <ds98rito@thn.htu.se>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010128172032.00a92030@pop.cus.cam.ac.uk>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 29 Jan 2001 16:31:03 +0100
Mime-Version: 1.0
Message-Id: <E14NGIq-0007nO-00@thn.htu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 2001 14:33:39 +0000, Anton Altaparmakov wrote:
> Can anyone tell me whether there is support for the HP Colorado 8Gb (IDE 
> version) tape drive in the Linux kernel and/or user space?
> 
> If there is kernel support which of the kernel options do I have to enable 
> / where do I get user space utilities from? Any pointers?
> 
> Thanks a lot for the help in advance.
> 
> Best regards,
> 
>          Anton



I have found this forum, when it comes to tape backup and Linux, to be
very good.
http://www.mailgate.org/linux/linux.dev.tape/

Especially this one might help you if you have a problem.
http://www.mailgate.org/linux/linux.dev.tape/msg00206.html

Here is some more info I found:
"I don't have the 8 GB, but I do have the 5 GB drive working.  You need
to make sure that support for the IDE/ATAPI tape drive is compiled
into your kernel.  Once your kernel supports IDE/ATAPI tape drives,
you should be able to access your drive via /dev/ht0 or /dev/nht0
(no rewind)."



-- 

/Richard

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
