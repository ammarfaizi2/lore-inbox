Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTE0RlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTE0RlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:41:02 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:20637 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264008AbTE0Rkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:40:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 27 May 2003 10:53:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Winischhofer <thomas@winischhofer.net>,
       Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
In-Reply-To: <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0305271050150.2340@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net> 
 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com> 
 <3ED32BA4.4040707@winischhofer.net>  <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
 <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Alan Cox wrote:

> I'm keeping an eye on it. The correct answer appears to be
> "use ACPI" once it works on SiS

ACPI does fix it. Sadly it rock crashes my machine.


> I'll probably try some of those changes in a later -ac and see what
> happens

Are you going to take care of this for 2.4 and 2.5 Alan ?
If yes I'd rather bail out, otherwise I'll continue to follow the 2.4 and
2.5 patch ..



- Davide

