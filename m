Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbVJMOl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbVJMOl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVJMOl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 10:41:57 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:12270 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751317AbVJMOl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 10:41:57 -0400
Message-ID: <434E7237.1070508@rtr.ca>
Date: Thu, 13 Oct 2005 10:41:59 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Drake <dsd@gentoo.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>	 <434D3266.9000203@gentoo.org>	 <1129139563.7966.4.camel@localhost.localdomain> <1129203917.18635.1.camel@localhost.localdomain>
In-Reply-To: <1129203917.18635.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> If the bus speed of your 486 is 25Mhz the chipset is at 25MHz as is your
> IDE (ie 486/25, DX2/50, 3/75 - not sure about 4/100 etc). Now does
> anyone know how you find out if the CPU is 25MHz bus clocked on a 486 8)

Same method as /proc/cpuinfo, for an approximation?  :)
