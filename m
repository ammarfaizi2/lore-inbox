Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSEYOsu>; Sat, 25 May 2002 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314652AbSEYOst>; Sat, 25 May 2002 10:48:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35828 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314641AbSEYOss>; Sat, 25 May 2002 10:48:48 -0400
Subject: Re: isofs unhide option:  troubles with Wine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy White <jwhite@codeweavers.com>
Cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1022334596.1262.6.camel@jwhiteh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 May 2002 16:50:22 +0100
Message-Id: <1022341822.11859.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 14:49, Jeremy White wrote:
> Yes, that is what we have to do now.  So, when our product is
> installed, a user is presented with a confusing, and highly technical
> question, the gist of which is:  please give us your root password
> so we can do something you don't understand.  It's okay, trust us,
> really...<grin>

Sounds like a job for rpm triggers and install scripts.

> Further, I would argue that if you accept that unhide is a
> reasonable default for me to force into the fstab, then
> it is a reasonable default for the kernel to have.

I'd tend to agree, simply because the defaults ought to make things
possible rather than impossible. Question is - why was hide the default
and what was that decision based upon ?

