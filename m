Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVHCROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVHCROH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVHCROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 13:14:07 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:1412 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262354AbVHCROF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 13:14:05 -0400
Message-ID: <42F0FB55.9000409@mrmighty.net>
Date: Wed, 03 Aug 2005 14:13:57 -0300
From: Stephen Ray <stephen@mrmighty.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Pavel Machek <pavel@ucw.cz>, James Bruce <bruce@andrew.cmu.edu>,
       David Weinehall <tao@acc.umu.se>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>	 <1122852234.13000.27.camel@mindpipe>	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>	 <20050802112529.GA7954@elf.ucw.cz> <1122991631.5490.29.camel@mindpipe>
In-Reply-To: <1122991631.5490.29.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-08-02 at 13:25 +0200, Pavel Machek wrote:
> 
>>BTW I think many architectures have HZ=100 even in 2.6, so it is not
>>as siple as "go 2.6"...
> 
> 
> Does not matter.  An app that only ever worked on 2.6 + x86 will break
> on 2.6.13.
> 
> Lee
> 

But then isn't that app broken?  What if the user running it selects 
something other than HZ=1000?

Stephen
