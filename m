Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRARRLb>; Thu, 18 Jan 2001 12:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRARRLV>; Thu, 18 Jan 2001 12:11:21 -0500
Received: from gate3.transcanada.com ([199.45.77.38]:64730 "EHLO
	cal-maila.tcpl.ca") by vger.kernel.org with ESMTP
	id <S130073AbRARRLE>; Thu, 18 Jan 2001 12:11:04 -0500
Message-ID: <3A6724CF.BD35FAFA@cal.montage.ca>
Date: Thu, 18 Jan 2001 10:15:59 -0700
From: Terrence Martin <tmartin@cal.montage.ca>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD cal-v4512  (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: File System Corruption with 2.2.18
In-Reply-To: <3A65DB02.56451E45@cal.montage.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to follow up, on Vojtech's advice I installed kernel 2.4.0 instead(I
also moved to 7.0 RH to accomplish this) and everything seems to be working
fine(I did not apply your new patches Vojtech, as yet they have not proved
necessary). I have not done any exhaustive testing, however the failure rate
has gone from boot kernel, wait 10 mins, write to disk fail, to no failures
at this point after installing many many RH7.0 updates etc...

Thanks for the assistance, and good work on the 2.4.0 kernel I am
impressed..:)

Cheers,

Terrence Martin



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
