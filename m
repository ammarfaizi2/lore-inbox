Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312772AbSDBExo>; Mon, 1 Apr 2002 23:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312773AbSDBExe>; Mon, 1 Apr 2002 23:53:34 -0500
Received: from mail.shorewall.net ([206.124.146.177]:15631 "EHLO
	mail.shorewall.net") by vger.kernel.org with ESMTP
	id <S312772AbSDBExb>; Mon, 1 Apr 2002 23:53:31 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Tom Eastep <teastep@shorewall.net>
Organization: Shoreline Firewall
To: Andre Pang <ozone@algorithm.com.au>, Steven Walter <srwalter@yahoo.com>,
        Danijel Schiavuzzi <dschiavu@public.srce.hr>,
        Tom Brehm <BrehmTomB@aol.com>, Bill Hammock <xcp@whisper.jaggnet.org>,
        Berend De Schouwer <bds@jhb.ucs.co.za>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Summary of KL133/KM133 problems w/2.4.18 (screen corruption/MWQ)
Date: Mon, 1 Apr 2002 20:52:50 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <1017644966.218140.3006.nullmailer@bozar.algorithm.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020402045327.4795D1B93C@mail.shorewall.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

On Sunday 31 March 2002 11:09 pm, Andre Pang wrote:

>
> Please test the patch if you have a VIA chipset at all; you
> should notice no change unless you have a K[LM]133, in which case
> the screen should be readable again ;).  It's against 2.4.18.
>
> If all goes well, I'll submit it to Alan/Marcelo/Dave.
>

Your patch corrects the video problems that I was experiencing while running 
2.4.18.

-Tom
-- 
Tom Eastep    \ Shorewall - iptables made easy
AIM: tmeastep  \ http://www.shorewall.net
ICQ: #60745924  \ teastep@shorewall.net
