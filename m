Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTCYJmD>; Tue, 25 Mar 2003 04:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbTCYJmD>; Tue, 25 Mar 2003 04:42:03 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:10395 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S261868AbTCYJmC>;
	Tue, 25 Mar 2003 04:42:02 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
Date: Tue, 25 Mar 2003 10:51:36 +0100
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.44.0303250313520.22808-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0303250313520.22808-100000@phoenix.infradead.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200303251051.36023.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h2P9r9v12679
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana utorak 25. mart 2003. 04:19 napisali ste:
>
> Its radeonfb now instead of radeon. Alot of drivers where broken in this
> way. Now every driver follows a standard.
>

	Nope, same thing with video=radeonfb...

>
> For console resizing try using stty cols xxx rows xx.
>
	Tried.  Not working again. Last line of the text is at same position like 
when changing mode with fbset, upper lines are now on the right where garbage 
is when using fbset.
	First scrolling gives an oops, but due to screen corruption I could not write 
down message displayed. Nothing in logs due to irregular reboot.

> >
> > 	My config is attached, gcc version is 2.95.3, modutils 2.4.21.
	
	Forgot to add, using GV-R9000  (GigaByte Maya R9000)
-- 
Pozdrav,
Tanasković Toplica


