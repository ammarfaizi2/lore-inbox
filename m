Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319701AbSIMQQK>; Fri, 13 Sep 2002 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319703AbSIMQQK>; Fri, 13 Sep 2002 12:16:10 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:36861
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319701AbSIMQQJ>; Fri, 13 Sep 2002 12:16:09 -0400
Subject: Re: kernel module and X
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Femitha Majeed <m_femitha@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F257qNI4lQ5tX60LUDA0000eb84@hotmail.com>
References: <F257qNI4lQ5tX60LUDA0000eb84@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 13 Sep 2002 17:22:12 +0100
Message-Id: <1031934132.9991.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 17:05, Femitha Majeed wrote:
> I have a kernel module that reads the files in the /proc directory. It works 
> fine when I am not using X. But when I use X, it gives me the follwoing 
> error in the log:

You don't give enough information. Look at "dmesg" and then debug your
module from the ksymoops data.

> XFree86 Version 4.1.0 (Red Hat Linux release: 4.1.0-3) / X Window System
> (protocol Version 11, revision 0, vendor release 6510)
> Release Date: 2 June 2001
> 	If the server is older than 6-12 months, or if your card is
> 	newer than the above date, look for a newer version before
> 	reporting problems.  (See http://www.XFree86.Org/FAQ)

          Also for X stuff ^^^^^^^^^^^^^^^^^^^^^^

