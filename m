Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270070AbTGQSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbTGQSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:51:39 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:29600 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269219AbTGQSsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:48:52 -0400
Date: Thu, 17 Jul 2003 19:59:52 +0100
From: backblue <backblue@netcabo.pt>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling, scsi 2.6.0-test1
Message-Id: <20030717195952.130827f5.backblue@netcabo.pt>
In-Reply-To: <1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
	<ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
	<20030716232827.2272eccb.backblue@netcabo.pt>
	<1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jul 2003 18:58:53.0394 (UTC) FILETIME=[776C7320:01C34C95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Alan,

I need this driver, but i dont know anouth of C, to code a new one, that old's on 2.6.0 :(, where to start? i really need it, i have everything scsi on my computer, with this controler, and i dont like the idea, of dont have suport to it!!
On 17 Jul 2003 12:51:42 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-07-16 at 23:28, backblue wrote:
> > I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?
> 
> Nobody has coverted this driver to 2.6 yet. If someone does then it will
> get merged in, if not the initio support will get deleted in time.
> 
