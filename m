Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRIVNfk>; Sat, 22 Sep 2001 09:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271032AbRIVNfa>; Sat, 22 Sep 2001 09:35:30 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:1193 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S270314AbRIVNfS>;
	Sat, 22 Sep 2001 09:35:18 -0400
Date: Sat, 22 Sep 2001 15:35:27 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious interrupt with ac kernel but not with vanilla
Message-ID: <20010922153527.B26955@se1.cogenit.fr>
In-Reply-To: <41B7E064ABA@vcnet.vc.cvut.cz> <XFMail.20010921192411.ast@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010921192411.ast@domdv.de>; from ast@domdv.de on Fri, Sep 21, 2001 at 07:24:11PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz <ast@domdv.de> :
[...]
> Same behaviour on a bunch of EpoX 8KTA+, KT133. Didn't care about it. Doesn't
> happen on a variety of PIII boards (Intel clones and Asus) so it looks like a
> KT133 issue. Kernel config is UP with APIC support on all systems.

Got it here on plain old Intel BX (Asus) + PII + vanilla. A few minutes or
one/two hours after reboot. So far, so good.

-- 
Ueimor
