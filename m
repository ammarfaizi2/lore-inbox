Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271208AbRHOPBZ>; Wed, 15 Aug 2001 11:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271216AbRHOPBH>; Wed, 15 Aug 2001 11:01:07 -0400
Received: from zeke.inet.com ([199.171.211.198]:38867 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S271208AbRHOPAy>;
	Wed, 15 Aug 2001 11:00:54 -0400
Message-ID: <3B7A8EA6.33C07179@inet.com>
Date: Wed, 15 Aug 2001 10:00:54 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.8-ac5
In-Reply-To: <20010814221556.A7704@lightning.swansea.linux.org.uk> <3B79B43D.B9350226@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Alan Cox wrote:
> > *
> > *       This is a fairly experimental -ac so please treat it with care
> > *
> >
> > 2.4.8-ac5
> 
> Hi Alan,
> 
> 2.4.8-ac5 makes the kpnpbios kernel thread go zombie here every time right
> during boot. I know that 2.4.8-ac1 didn't have this problem, but didn't try
> -ac2 to -ac4. If you want me to check which -ac release was the last that
> got it right, just say and I'll check.

I noticed a [kpnpbios <defunct>] on the 2.4.8-ac3 I built at home.

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
