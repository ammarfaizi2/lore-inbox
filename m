Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLMEMx>; Tue, 12 Dec 2000 23:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLMEMo>; Tue, 12 Dec 2000 23:12:44 -0500
Received: from [200.216.82.160] ([200.216.82.160]:39176 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129226AbQLMEMd>; Tue, 12 Dec 2000 23:12:33 -0500
Date: Wed, 13 Dec 2000 01:41:54 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: USB mass storage backport status?
Message-ID: <20001213014154.H1245@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the real status of the mass storage backport to 2.2.18?
Some people report it can corrupt your data, another that it
rebooted his computer while doing a large trasnfer, and so on.

If it's not good, shouldn't it be removed or labeled
DANGEROUS? BTW, where can I see a list of what's backported
and working without major problems?

-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
