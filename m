Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281659AbRKQAMj>; Fri, 16 Nov 2001 19:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281660AbRKQAM3>; Fri, 16 Nov 2001 19:12:29 -0500
Received: from [213.97.184.209] ([213.97.184.209]:43139 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S281659AbRKQAMS>;
	Fri, 16 Nov 2001 19:12:18 -0500
Date: Sat, 17 Nov 2001 01:12:09 +0100 (CET)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Limiting cache on device basis.
Message-ID: <Pine.LNX.4.33.0111170103430.8891-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I would like to know if it is possible to limit the maximum
cache used by a device. If not, wouldn't it be usefull? for example,
you may want to limit the maximum cache used for /video (big IDE HD)
to the minimum necesary to let you write arbitrary sized files to the
HD, so you don't need to fix your files size. It would be usefull also
to limit the cache, so /usr or /var or even /lib get enough cached as
to allow important bits are keep in memory. Of course this could be
set as a mount option. If setting absolute cache percent or size isn't
nice, it could be done using priority settings.

	Regards,

	- german

PS: Please CC'd to me as I'm not subscribed to the list. Thanks.
-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

