Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUHCRaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUHCRaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUHCRaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:30:03 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:28939 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S266756AbUHCR3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:29:51 -0400
Date: Tue, 3 Aug 2004 14:14:33 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Lei Yang <leiyang@nec-labs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: Problem installing cloop
Message-ID: <20040803171433.GC925@lorien.prodam>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>
References: <1091563549.5487.62.camel@bijar.nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091563549.5487.62.camel@bijar.nec-labs.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Lei,

Em Tue, Aug 03, 2004 at 01:05:50PM -0700, Lei Yang escreveu:

| I was trying to get
| cloop-2.0.1 built and installed on a SuSe 9.1 box with kernel version
| 2.6.5 . I followed all the instructions in    
| http://www.knopper.net/download/knoppix/cloop.README

 Well, I did a cleanup in the cloop code, merged it in 2.6.7, and
enabled it in Kconfig:

 The patch is here:

http://www.telecentros.sp.gov.br/capitulino/patches/linux/2.6/cloop/2.6.7/

 I did it for another project some weeks ago, sorry for not posting
it here before (But, as far as I can remember, I sent it to knopper).

PS: Its a patch again't the kernel, you will have to get the standard
tools from knopper page.

 Hope it helps,

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
