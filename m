Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTDQREm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTDQREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:04:42 -0400
Received: from tag.witbe.net ([81.88.96.48]:11795 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261722AbTDQREl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:04:41 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Pau Aliagas'" <linuxnow@newtral.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67
Date: Thu, 17 Apr 2003 19:16:36 +0200
Message-ID: <018401c30505$1a1e6200$6400a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <Pine.LNX.4.44.0304171900490.1143-100000@pau.intranet.ct>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the same starting with 2.5.67...
I took the .config from the booting 2.5.66, made a 2.5.67 kernel,
and when booting, booh :-(

It was a RH8 base, Lilo... I'll try tonite to find out which option
is responsible of that...

Regards,
Paul

> I have a rh9 installation, grub is properly configured, and 
> when I select 
> to boot a 2.5 kernel it does not even decompress it. It stops 
> even before 
> printing the kernel version.
> 

