Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbQL0Sk5>; Wed, 27 Dec 2000 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbQL0Skr>; Wed, 27 Dec 2000 13:40:47 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:9358 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129953AbQL0Skh>;
	Wed, 27 Dec 2000 13:40:37 -0500
Message-ID: <3A4A3082.A6975F7C@voicenet.com>
Date: Wed, 27 Dec 2000 13:10:10 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-pre3-scsi-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
CC: Felix von Leitner <leitner@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
In-Reply-To: <4.3.2.7.2.20001227105214.00beaf00@cam-pop.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:

>
> On IDE, you don't. IDE never supports hot-swap, RAID or no. If you want
> that, use SCSI.

That's not necessarily true.  There is work in linux to support Tri-stating
the ide devices with the help of a custom card that will allow one to cut
power to a specific ide device. Tri-stating allows Hot Swapping of ide
devices now.  I even had a picture of the device the person is using to hot
swap.  I'm sorry that I have forgotten this kernel hackers name as i have
lost the original email Along with said picture. I'm pretty sure the person
who gave it to me was 2.4.x's IDE guy but I cant be sure right now.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
