Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTJTWNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJTWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:13:42 -0400
Received: from [62.67.222.139] ([62.67.222.139]:61650 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262563AbTJTWNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:13:41 -0400
Date: Tue, 21 Oct 2003 01:05:10 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Message-ID: <20031020230510.GD15563%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031020132705.GA1171@synertronixx3> <3F93E728.5050908@inet6.fr> <20031020144822.GA593@synertronixx3> <3F93FA5E.2020300@inet6.fr> <20031020215401.GB15563%konsti@ludenkalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020215401.GB15563%konsti@ludenkalle.de>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Konstantin Kletschke <konsti@ludenkalle.de> [Mon, Oct 20, 2003 at 11:54:01PM +0200]:
> 
> > K7S5A Pro are dirt cheap these days, so it might be a good idea to buy a 
> > new one.
> 
> Thats it, bought Board and PSU, for 55EUR...

While at this point...

The new K7S5A Pro behaves strange.

When lilo comes up, it gets keyboard input containing of 4-6 lines
"t:t:t:t:t:t:t:t:t:t:t:t:"...
When hitting backspace whole line gets cleared, enter boots default then.
WTF?
even with no keyboard plugged in. My first thought was disabling
"usb-keyboard support for dos" but... only a usb printer, ethernet and
serial modem are plugged in...

Regards, Konsti

-- 
2.6.0-test6-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 5:15, 7 users
