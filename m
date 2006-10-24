Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWJXPbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWJXPbb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWJXPbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:31:31 -0400
Received: from main.gmane.org ([80.91.229.2]:28330 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965054AbWJXPba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:31:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [BUG] DMA timeout errors on Dell Latitude XPi CD P150ST
Date: Tue, 24 Oct 2006 15:30:37 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejscpa.93p.olecom@flower.upol.cz>
References: <ae7121c60610240805l6f244bf5vdad31d6fd17e10f7@mail.gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-24, Panagiotis Issaris wrote:
> ------=_Part_12761_28196610.1161702311028
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline
>
> Hi,
>
> When booting Linux 2.6.19-rc3 (or 2.6.8-16sarge5 so it is not specific
> to the current kernels) on a friends laptop, I'm getting a lot of
> errormessages from the IDE controller related to DMA problems. When
[]
> cpuinfo:
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 5
> model           : 2
> model name      : Pentium 75 - 200

Are we in museum?..

> stepping        : 12
> cpu MHz         : 150.348
> cache size      : 0 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no

(without even f00f bug?) ... no we are not ;)

> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr mce cx8
> bogomips        : 301.97
>
[]
> eQpDT05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpDT05GSUdfWDg2X0JJT1NfUkVCT09UPXkKQ09O
> RklHX0tUSU1FX1NDQUxBUj15Cg==
> ------=_Part_12761_28196610.1161702311028--

____

