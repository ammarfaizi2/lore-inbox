Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276028AbRJBRKx>; Tue, 2 Oct 2001 13:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276030AbRJBRKn>; Tue, 2 Oct 2001 13:10:43 -0400
Received: from mail104.mail.bellsouth.net ([205.152.58.44]:2225 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S276018AbRJBRKa>; Tue, 2 Oct 2001 13:10:30 -0400
Message-ID: <3BB9F527.82B86728@hcssystems.com>
Date: Tue, 02 Oct 2001 13:11:03 -0400
From: Josh Wyatt <josh.wyatt@hcssystems.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Alan Ford <alan@whirlnet.co.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre2
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com>
		<200110012218.f91MIGU10233@hswn.dk>
		<20011002125040.A10878@whirlnet.co.uk> <20011002143939.34e5cd62.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> On Tue, 2 Oct 2001 12:50:40 +0100 Alan Ford <alan@whirlnet.co.uk> wrote:
> 
> > -     action_msg:     "Emergency Remount R/0\n",
> > +     action_msg:     "Emergency Remount R/O\n",
> 
> What exactly do you want to fix with this patch?

Disclaimer: It ain't my patch :) .
But it looks like the old version used a "0" (zero) in R/O, and the new
version uses an "O" (oh).

> Regards,
> Stephan

Regards,
Josh

