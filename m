Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbRE1FBC>; Mon, 28 May 2001 01:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbRE1FAw>; Mon, 28 May 2001 01:00:52 -0400
Received: from hamachi.synopsys.com ([204.176.20.26]:5104 "EHLO
	hamachi.synopsys.com") by vger.kernel.org with ESMTP
	id <S262963AbRE1FAh>; Mon, 28 May 2001 01:00:37 -0400
Message-ID: <3B11DB3A.E99D0895@Synopsys.COM>
Date: Mon, 28 May 2001 06:59:38 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chris Rankin <rankinc@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Overkeen CDROM disk-change messages
In-Reply-To: <E1548ST-0002Og-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no CD in the drive, why are there messages in kern.log 
about a CD change? Shouldn't it be something like 'CD drive empty'?

Harri
