Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbTCWAmR>; Sat, 22 Mar 2003 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbTCWAmR>; Sat, 22 Mar 2003 19:42:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39069
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262181AbTCWAmQ>; Sat, 22 Mar 2003 19:42:16 -0500
Subject: Re: 2.5.65-ac2:  Zip drive problem continues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7CF5D1.9020901@myrealbox.com>
References: <3E7CF5D1.9020901@myrealbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048385134.10712.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 02:05:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I compile ppa into the kernel it causes a panic at boot.
> If I compile it as a module it still causes error messages
> when loaded, and doesn't work properly.

Can you put a report in bugzilla.kernel.org and include the
message/panic info for both cases. That way the bug report won't
get lost before 2.6.0. 

In theory ppa should be working but I don't have ppa hardware

