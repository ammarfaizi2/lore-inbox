Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTJTVDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTJTVDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:03:36 -0400
Received: from [62.67.222.139] ([62.67.222.139]:36305 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262796AbTJTVCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:02:30 -0400
Date: Mon, 20 Oct 2003 23:54:01 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Message-ID: <20031020215401.GB15563%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031020132705.GA1171@synertronixx3> <3F93E728.5050908@inet6.fr> <20031020144822.GA593@synertronixx3> <3F93FA5E.2020300@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F93FA5E.2020300@inet6.fr>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lionel Bouton <Lionel.Bouton@inet6.fr> [Mon, Oct 20, 2003 at 05:08:14PM +0200]:
> 
> Maybe... do you mean your CMOS settings are periodically reset ? In this 
> case it usually is simply a worn-out battery.

No, I replaced it already, it is also a known K7S5A bug, once a month it
looses CMOS. BTW, near the last PCI Slot was a little square Button
labeled with a "5".

> K7S5A Pro are dirt cheap these days, so it might be a good idea to buy a 
> new one.

Thats it, bought Board and PSU, for 55EUR...

> perfectly. You should install the smartmontools and run smartd 
> configured to send you an e-mail each time a new defect is found. You 

Yes, absolutely...

Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 4:06, 8 users
