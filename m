Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUAFS0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUAFS0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:26:19 -0500
Received: from smtp2.libero.it ([193.70.192.52]:15235 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265056AbUAFS0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:26:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16378.65140.114558.996798@gargle.gargle.HOWL>
Date: Tue, 6 Jan 2004 19:29:08 +0100
To: Duncan Sands <baldrick@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
In-Reply-To: <200312301702.26973.baldrick@free.fr>
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
	<200312300911.02044.baldrick@free.fr>
	<16369.40927.110483.701341@gargle.gargle.HOWL>
	<200312301702.26973.baldrick@free.fr>
X-Mailer: VM 7.03 under Emacs 21.2.1
From: "Guldo K" <guldo@tiscali.it>
Reply-to: "Guldo K" <guldo@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Maybe you should start with 2.4 and not 2.6.

Thanks for your help.

I compiled 2.4.22, and tried to install speedbundle;
but it looks like I still have the very same error
messages... I'd try and understand what kernel headers
*are* (sorry), but in the meantime I switched back to
the user driver.
One more thing to ask you: I discarded all the config
made for the kernel driver (I think so...), but as I plug
my modem in, the speedtch module is loaded.
I have to unload it in order to get modem_run to work
properly with the user driver.
Why is it so? How can I make speedtch not to be loaded
automatically, if I can?
(without recompiling the kernel)

Thank you very much!

 > Ciao,
 > 
 > Duncan.

Ciao,

*Guldo*

