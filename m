Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270256AbRHNDzm>; Mon, 13 Aug 2001 23:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270312AbRHNDzb>; Mon, 13 Aug 2001 23:55:31 -0400
Received: from mx12.nameplanet.com ([62.70.3.42]:7428 "HELO
	mx12.nameplanet.com") by vger.kernel.org with SMTP
	id <S270256AbRHNDzV>; Mon, 13 Aug 2001 23:55:21 -0400
Date: 14 Aug 2001 03:55:27 -0000
Message-ID: <20010814035527.23172.qmail@www2.nameplanet.com>
From: david@shepard.tc
To: cardhore@yahoo.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: cs4232 sound chip problem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed this pop for quite some time at sound initialization when starting KDE on my IBM Thinkpad A20M. Also, there was a problem with XMMS killing sound if it was closed, but the sound would come back if I left it alone for a while. Anyway, my laptop has a cs4622 in it, and I suspect you are using the other Crystal Sound driver (not cs46xx). Someone mentioned something earlier on the list that started me to thinking it might be a problem with the ac97_codec. I believe they also mentioned some changes to the ac97_codec in the most recent release kernel. You might give that a try. Or perhaps I'll just let you know if the pop goes away...

-- 
Get your firstname@lastname email for FREE at http://Nameplanet.com/?su
