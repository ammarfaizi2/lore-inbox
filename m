Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131591AbQLLBW2>; Mon, 11 Dec 2000 20:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbQLLBWS>; Mon, 11 Dec 2000 20:22:18 -0500
Received: from [200.222.195.150] ([200.222.195.150]:56068 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S131591AbQLLBWE>; Mon, 11 Dec 2000 20:22:04 -0500
Date: Mon, 11 Dec 2000 22:51:33 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-pci.c: typo
Message-ID: <20001211225133.D1245@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> I disagree with the patch. The bug is in printk

No problem. So, it's a bug report instead. I have no clues,
and just thought it'd be a fix :)

Not sure if 2.2.17 reported the double %% from syslog. I
usually look at my dmesg.

-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
