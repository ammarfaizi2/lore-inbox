Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbSIPRu0>; Mon, 16 Sep 2002 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262759AbSIPRu0>; Mon, 16 Sep 2002 13:50:26 -0400
Received: from wild.cs.colorado.edu ([128.138.207.131]:63185 "HELO
	wild.cs.colorado.edu") by vger.kernel.org with SMTP
	id <S262758AbSIPRu0>; Mon, 16 Sep 2002 13:50:26 -0400
Date: Mon, 16 Sep 2002 12:56:04 -0600 (MDT)
From: Stephen Aiken <aikens@colorado.edu>
X-X-Sender: aikens@wild
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.4 and 2.5 with KVM/mouse
In-Reply-To: <1031702431.3086.36.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0209161249420.1769-100000@wild>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Now, on my test machine running 2.5 the mouse works until I do a KVM
>machine swap. Then the 2.5 machine never clears up the mouse wackiness
>and the only choice is to reboot. 

Have you tried restarting gpm?

-Steve
--
The day after tomorrow is the third day of the rest of your life.

