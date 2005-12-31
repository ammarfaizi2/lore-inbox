Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVLaPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVLaPfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVLaPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:35:18 -0500
Received: from [202.67.154.148] ([202.67.154.148]:54953 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S964992AbVLaPfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:35:16 -0500
Message-ID: <43B6A502.20709@ns666.com>
Date: Sat, 31 Dec 2005 16:34:26 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps	crashing
References: <43B53EAB.3070800@ns666.com>	 <200512310027.47757.s0348365@sms.ed.ac.uk>	 <43B5D3ED.3080504@ns666.com>	 <200512310051.03603.s0348365@sms.ed.ac.uk>	 <43B5D6D0.9050601@ns666.com>	 <43B65DEE.906@ns666.com>	 <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>	 <43B66E3D.2010900@ns666.com>	 <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com>	 <43B67DB6.2070201@ns666.com>  <43B6A14E.1020703@ns666.com> <1136042571.2901.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1136042571.2901.30.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2005-12-31 at 16:18 +0100, Mark v Wolher wrote:
> 
>>Dec 31 16:11:35 localhost kernel: Modules linked in: nv
> 
> 
> I think you forged this oops... there's no "nv" module for nvidia cards.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


eh mate, i was copy/pasting the info and making notes, i didn't see i
wrote nv there. (I keep a detailed log of what i did, notes, drivers,
what disabled/never loaded etc)

Don't judge to quickly and have some trust in people mate.

So for your information, no nvidia binary module was loaded
(uninstalled it) and only the kernel part is used.
