Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRCEVfh>; Mon, 5 Mar 2001 16:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbRCEVf2>; Mon, 5 Mar 2001 16:35:28 -0500
Received: from [209.143.110.29] ([209.143.110.29]:18695 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S130685AbRCEVfW>; Mon, 5 Mar 2001 16:35:22 -0500
Message-ID: <3AA406FC.31A212C@the-rileys.net>
Date: Mon, 05 Mar 2001 16:37:00 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <E14a26R-0007lp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 2.4.2-ac12
> o       Update VIA IDE driver to 3.21                   (Vojtech Pavlik)
>         |No UDMA66 on 82c686

Um... Does that include 686a?  82c686a is supposed to handle UDMA66...
Or is it a corruption issue again?  UDMA66 seems to work fine on
mine...  No corruptions yet.
