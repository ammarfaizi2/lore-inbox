Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbRERBtI>; Thu, 17 May 2001 21:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbRERBs6>; Thu, 17 May 2001 21:48:58 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:15891 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262229AbRERBso>; Thu, 17 May 2001 21:48:44 -0400
Date: Thu, 17 May 2001 21:47:00 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac11
Message-ID: <20010517214700.A15306@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E150XLO-0006NY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150XLO-0006NY-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 12:38:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(catching up...)

Alan Cox (alan@lxorguk.ukuu.org.uk) said: 
> 2.4.4-ac9
...
> o	Further tulip updates				(Jeff Garzik)
...
> 2.4.4-ac8
> o	Tulip driver updates				(Jeff Garzik)

These updates (sorry, haven't tracked down which of the two) conspire to
break the tulip on my ia64, it's a:

02:01.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip
Pass 3] (rev 21)

What normally happens is that all the TX packets show up
as carrier errors, and no packets are ever recieved.

Bill
