Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSIPW23>; Mon, 16 Sep 2002 18:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSIPW23>; Mon, 16 Sep 2002 18:28:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5898 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263232AbSIPW23>;
	Mon, 16 Sep 2002 18:28:29 -0400
Subject: Re: Problems with 2.4 and 2.5 with KVM/mouse
From: Stephen Hemminger <shemminger@osdl.org>
To: Stephen Aiken <aikens@colorado.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209161249420.1769-100000@wild>
References: <Pine.LNX.4.44.0209161249420.1769-100000@wild>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 15:33:25 -0700
Message-Id: <1032215605.17016.3.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No change when gpm is killed and restarted

On Mon, 2002-09-16 at 11:56, Stephen Aiken wrote:
> >Now, on my test machine running 2.5 the mouse works until I do a KVM
> >machine swap. Then the 2.5 machine never clears up the mouse wackiness
> >and the only choice is to reboot. 
> 
> Have you tried restarting gpm?
> 
> -Steve
> --
> The day after tomorrow is the third day of the rest of your life.


