Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRDPXDn>; Mon, 16 Apr 2001 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRDPXDd>; Mon, 16 Apr 2001 19:03:33 -0400
Received: from t2.redhat.com ([199.183.24.243]:12029 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132399AbRDPXDV>; Mon, 16 Apr 2001 19:03:21 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0104141612250.27637-100000@cs865114-a.amp.dhs.org> 
In-Reply-To: <Pine.LNX.4.33.0104141612250.27637-100000@cs865114-a.amp.dhs.org> 
To: Arthur Pedyczak <arthur-p@home.com>
Cc: Aaron Lunansky <alunansky@rim.net>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Apr 2001 00:02:03 +0100
Message-ID: <6962.987462123@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


arthur-p@home.com said:
>  Well, I wrote the script. It has been running for 10 minutes now
> mounting and unmounting an iso image. Nothing happens. I guess I
> should be happy. Still don't undertand where the original Oops came
> from 


It's a great shame that your distribution vendor shipped klogd configured 
to destroy information. Please make sure you've reported this bug to them.

--
dwmw2


