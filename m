Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135521AbRD3SeS>; Mon, 30 Apr 2001 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135516AbRD3SeJ>; Mon, 30 Apr 2001 14:34:09 -0400
Received: from thunderer.concentric.net ([207.155.252.72]:44990 "EHLO
	thunderer.cnchost.com") by vger.kernel.org with ESMTP
	id <S135328AbRD3Sdy>; Mon, 30 Apr 2001 14:33:54 -0400
Message-ID: <3AEDAFF7.556822B5@aerizen.com>
Date: Mon, 30 Apr 2001 11:33:27 -0700
From: John Silva <jps@aerizen.com>
Organization: None
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18-18mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Hosler <hosler@lugs.org.sg>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via VT82C686 data sheet
In-Reply-To: <XFMail.010430205941.hosler@lugs.org.sg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Via Product Datasheet Page
http://www.via.com.tw/support/datasheets.htm

Via Apollo Pro 82C686A
http://www.via.com.tw/pdf/productinfo/686a.pdf

VIA Document Request Form
http://www.via.com.tw/contact/datasheets.htm

-J.


Greg Hosler wrote:
> 
> Does anyone have, or know where I can get a copy of the above ?
> 
> The onboard AC97 sound driver (via82cxxx_audio) was rewritten from legacy
> (which works both in UP and SMP kernels), to do w/o the legacy support,
> and go native. The problem is that the new driver doesn't properly handle
> enabling interrupts for the case when the IRQ has been reassigned (by
> the I/O APIC, which is typical under SMP). (actually the via82cxxx_audio
> has code to try to handle the reassignment of the IRQ, but it doesn't work).
> 
> I'm looking to see a copy of the datasheet on the 82C686, to see if I can
> debug this further.
> 
> thx for any pointers, and rgds,
> 
> -Greg
> 
> +---------------------------------------------------------------------+
> "DOS Computers manufactured by companies such as IBM, Compaq, Tandy, and
> millions of others are by far the most popular, with about 70 million
> machines in use wordwide. Macintosh fans, on the other hand, may note that
> cockroaches are far more numerous than humans, and that numbers alone do
> not denote a higher life form."       (New York Times, November 26, 1991)
> | Greg Hosler                           i-net:  hosler@lugs.org.sg    |
> +---------------------------------------------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
John P. Silva                            jps@aerizen.com
