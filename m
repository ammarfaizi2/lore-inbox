Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRC3KkJ>; Fri, 30 Mar 2001 05:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRC3Kj7>; Fri, 30 Mar 2001 05:39:59 -0500
Received: from rmx308-mta.mail.com ([165.251.48.43]:50054 "EHLO
	rmx308-mta.mail.com") by vger.kernel.org with ESMTP
	id <S131296AbRC3Kjs>; Fri, 30 Mar 2001 05:39:48 -0500
From: arobertson@altavista.net
MIME-Version: 1.0
Message-Id: <010330053908BW.01312@weba6.iname.net>
Date: Fri, 30 Mar 2001 05:39:08 -0500 (EST)
Content-Type: Text/Plain
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 in 2.4.2 on Toshiba Tecra 8000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Reimer (k@ailis.de) said:> 2001-03-29
10:02:50.054774500 {kern|info} kernel: ad1848/cs4248
codec driver 
> Copyright (C) by Hannu Savolainen 1993-1996
> 2001-03-29 10:02:50.070692500 {kern|notice} kernel:
opl3sa2: No cards found
> 2001-03-29 10:02:50.070703500 {kern|notice} kernel:
opl3sa2: 0 PnP card(s) 
> found.

Tried to post this from another account yesterday but it
seemed to go awol :)

I had a similar problem when I moved from 2.4.1 to 2.4.2
with a tecra 8000. 

The solution was to use 2.4.2ac20 which appears to solve
the problem. The opl3 code changed between kernel
versions.No BIOS or modules.conf were harmed....

Rgds,

Alan


----------------------------------------------------------------
Get your free email from AltaVista at http://altavista.iname.com
