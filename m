Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVDGM3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVDGM3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVDGM3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:29:36 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:12931 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S262442AbVDGM3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:29:33 -0400
Message-ID: <4255278E.4000303@almg.gov.br>
Date: Thu, 07 Apr 2005 09:29:02 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: David Schmitt <david@black.co.at>, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <L0f93D.A.68G.D2OVCB@murphy>
In-Reply-To: <L0f93D.A.68G.D2OVCB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schmitt wrote:

>  On Thursday 07 April 2005 09:25, Jes Sorensen wrote:
>
> > [snip] I got it from Alteon under a written agreement stating I
> > could distribute the image under the GPL. Since the firmware is
> > simply data to Linux, hence keeping it under the GPL should be just
> > fine.
>
>
>  Then I would like to exercise my right under the GPL to aquire the
>  source code for the firmware (and the required compilers, starting
>  with genfw.c which is mentioned in acenic_firmware.h) since - as far
>  as I know - firmware is coded today in VHDL, C or some assembler and
>  the days of hexcoding are long gone.

First, there is *NOT* any requirement in the GPL at all that requires 
making compilers available. Otherwise it would not be possible, for 
instance, have a Visual Basic GPL'd application. And yes, it is possible.

Second, up until the present day I have personal experience with 
hardware producers that do not have enough money to buy expensive 
toolchains and used a lot of hand-work to code hardware parameters. So, 
at least for them, hand-hexcoding-days are still going.

HTH,

Massa



