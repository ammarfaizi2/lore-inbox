Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272318AbTG3XCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTG3XCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:02:19 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:3575 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272318AbTG3XCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:02:16 -0400
Subject: Re: Dell 2650 Dual Xeon freezing up frequently
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: nelsonis@earthlink.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F283E3A.7060200@earthlink.net>
References: <3F283E3A.7060200@earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059605809.10452.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 23:56:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 22:52, Ian S. Nelson wrote:
> I'm running a RedHat 2.4.20 kernel on some 2650's   all dual xeon 
> (pentium 4 jacksonized  so it looks like 4 procsessors)  2 have 1GB of 
> RAM and 1 has 2GB of RAM.   THey all wedge, some times after a few 
> minutes,  sometimes after hours.

With tg3 networking. If so make sure you either have a current errata or
switch to the broadcom provided driver and that may help.

