Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRFYISq>; Mon, 25 Jun 2001 04:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRFYISg>; Mon, 25 Jun 2001 04:18:36 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:19705
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S262389AbRFYISU>; Mon, 25 Jun 2001 04:18:20 -0400
Subject: Re: Thrashing WITHOUT swap.
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15EHYP-0000VC-00@the-village.bc.nu>
In-Reply-To: <E15EHYP-0000VC-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 25 Jun 2001 10:13:35 +0200
Message-Id: <993456815.2339.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2001 22:36:25 +0100, Alan Cox wrote:
> > recompiled it yet).  I have a 140 mb swap partition set up but at the time
> > this happened it was OFF.  I was (still am) running X + twm + two xterms
> > 
> > top gives me:
> > mem: 62144k av, 61180k used, 956k free, 0k shrd, 76 buff, 2636 cached
> > swap: 0k av, 0k used, 0k free [as expected]
> 
> Not as expected - 0k used 0k free - you have no swap

That's what he said. *WITHOUT* swap.

Xav
