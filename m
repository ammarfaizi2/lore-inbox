Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLYBfN>; Sun, 24 Dec 2000 20:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLYBfE>; Sun, 24 Dec 2000 20:35:04 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:17329 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129455AbQLYBev>; Sun, 24 Dec 2000 20:34:51 -0500
Message-ID: <3A469D11.B7DCFCD8@haque.net>
Date: Sun, 24 Dec 2000 20:04:17 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Gilbert <gilbertd@treblig.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
In-Reply-To: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works fine under test13-pre4 here on a x86 and an ATAPI Creative 2x dvd
drive using xine or dxr2 player.

Dave Gilbert wrote:
> 
> Hi,
>   Somewhere between test12 and test13pre4ac2 (sheesh the version
> numbers.....) CSS on ATAPI DVD ROM drives has stopped working.
> 
> Playing a CSS disc (using xine) causes a complete system hang (machine
> doesn't ping - sysrq-b still works) on test13pre4ac2.  On test12 it is
> still OK.
> 
> This is on an Alpha LX164.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
