Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286282AbRL0Nry>; Thu, 27 Dec 2001 08:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286278AbRL0Nre>; Thu, 27 Dec 2001 08:47:34 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:22733 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S286274AbRL0Nrd>; Thu, 27 Dec 2001 08:47:33 -0500
Date: 27 Dec 2001 14:26:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8FeKjZHHw-B@khms.westfalen.de>
In-Reply-To: <p05101000b84a980dd9e1@[10.0.0.42]>
Subject: Re: Configure.help editorial policy
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <p05101000b84a980dd9e1@[10.0.0.42]>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tas@mindspring.com (Timothy A. Seufert)  wrote on 22.12.01 in <p05101000b84a980dd9e1@[10.0.0.42]>:

> Vojtech Pavlich wrote:
>
> >4Mbit bandwidth is usually 4 * 10^3 * 2^10 bits per second.
> >20GB harddrive is usually 20 * 10^6 * 2^10 bytes.
>
> A 20 GB hard drive is always 20 * 10^9 bytes.  I'm not sure why so
> many people on the linux-kernel list think otherwise, but the hard
> drive industry is quite consistent in its use of power-of-10 units to
> describe capacity.  See:

>From dmesg:

"195371568 sectors (100030 MB)" (calls itself 100)
"8250001 512-byte hdwr sectors (4224 MB)" (calls itself 4330)

I take back whatever I said. It's not 1024^n. It's not 1024*1000^n. It's  
not 1000^n. I don't know what it is, except it's all a lie.

MfG Kai
