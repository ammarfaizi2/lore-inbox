Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130704AbRCEVuF>; Mon, 5 Mar 2001 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130702AbRCEVt5>; Mon, 5 Mar 2001 16:49:57 -0500
Received: from rodney.concentric.net ([207.155.252.4]:40132 "EHLO
	rodney.cnchost.com") by vger.kernel.org with ESMTP
	id <S130698AbRCEVtF>; Mon, 5 Mar 2001 16:49:05 -0500
Message-ID: <3AA409AA.BD6B1631@aerizen.com>
Date: Mon, 05 Mar 2001 13:48:26 -0800
From: John Silva <jps@aerizen.com>
Organization: None
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-14mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Riley <oscar@the-rileys.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <E14a26R-0007lp-00@the-village.bc.nu> <3AA406FC.31A212C@the-rileys.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've used 82c686a at UDMA66 on MSI 694D with WD418000 and standard UDMA66 18"
cables quite successfully.


David Riley wrote:

> Alan Cox wrote:
> > 2.4.2-ac12
> > o       Update VIA IDE driver to 3.21                   (Vojtech Pavlik)
> >         |No UDMA66 on 82c686
>
> Um... Does that include 686a?  82c686a is supposed to handle UDMA66...
> Or is it a corruption issue again?  UDMA66 seems to work fine on
> mine...  No corruptions yet.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

