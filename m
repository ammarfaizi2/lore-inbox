Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264921AbUELJlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUELJlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 05:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUELJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 05:41:51 -0400
Received: from adsl-static-1-36.uklinux.net ([62.245.36.36]:60375 "EHLO
	bristolreccc.co.uk") by vger.kernel.org with ESMTP id S264921AbUELJlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 05:41:47 -0400
Subject: Re: problem with sis900 driver 2.6.5 +
From: mike <mike@bristolreccc.co.uk>
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040511184142.GE12947@lorien.prodam>
References: <1084300104.24569.8.camel@datacontrol>
	 <20040511184142.GE12947@lorien.prodam>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 10:37:55 +0100
Message-Id: <1084354675.24569.10.camel@datacontrol>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 15:41 -0300, Luiz Fernando N. Capitulino wrote:
>  Hi Mike,
> 
> Em Tue, May 11, 2004 at 07:28:24PM +0100, mike escreveu:
> 
> | In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
> | a problem with the sis900 eth driver
> | 
> | I have a sis chipset with integrated ethernet sis900 driver which has
> | always worked perfectly up to and including 2.6.3 (fedora)
> | 
> | Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
> | up
> | 
> | relevant messages
> | 
> | sis900 device eth0 does not appear to be present delaying initialisation
> | 
> | and from dmesg eth0: cannot find ISA bridge
> 
>  Where you got it ?
> 
> | lsmod shows sis and sis900 modules loaded fine
> 
>  Is the interface up ?

nope the first message is what I get when I run ifup eth0
ie: sis900 device eth0 does not appear to be present delaying initialisation
> | 
> -- 
> Luiz Fernando N. Capitulino
> <http://www.telecentros.sp.gov.br>
> 
> 
