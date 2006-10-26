Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423482AbWJZNCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423482AbWJZNCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423481AbWJZNCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:02:43 -0400
Received: from adsl-ull-235-236.42-151.net24.it ([151.42.236.235]:19752 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1423479AbWJZNCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:02:41 -0400
Message-ID: <4540B136.8050908@abinetworks.biz>
Date: Thu, 26 Oct 2006 14:59:34 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Giacomo A. Catenazzi" <cate@debian.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       proski@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	 <1161808227.7615.0.camel@localhost.localdomain>	 <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain> <4540A867.307@debian.org>
In-Reply-To: <4540A867.307@debian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi wrote:

> I'm confused on the discussion:
> legal? I don't find how a windo$e driver can be "derived work" of Linux,
> and anyway they use a "standard" interface. So it is acceptable for GPL
> (IMHO and IANAL). so it is not a legal problem.
>
> I see only a development question:
> should we allow untrusted module to know and modify the
> "intimate" part of kernel, and cause compability and other large
> amount of problems into kernel developers, distribution and users?
>
I really cannot see even a political problem. I the case of ndiswrapper 
the problem is not whether we want to support windows or whatever 
drivermodules, but if we want to support NDIS drivers with a GPL wrapper.

regards,

Gianluca

> So it is a political question, not a legal question!
>
> ciao
>     cate
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


