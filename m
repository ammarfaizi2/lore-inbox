Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVE0Rr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVE0Rr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVE0Rr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:47:58 -0400
Received: from opersys.com ([64.40.108.71]:42767 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261923AbVE0Rr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:47:29 -0400
Message-ID: <42975D0A.7070608@opersys.com>
Date: Fri, 27 May 2005 13:46:50 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050525005942.GA24893@nietzsche.lynx.com>	 <1116982977.19926.63.camel@dhcp153.mvista.com>	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>	 <20050526193230.GY86087@muc.de>	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>	 <20050526202747.GB86087@muc.de>  <4296ADE9.50805@yahoo.com.au> <1117178430.6138.16.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1117178430.6138.16.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[side-note]

Sven-Thorsten Dietrich wrote:
> If you are truly interested, there are a lot of papers about RT. There
> are nanokernel implementations and patents you can review, and there is
> a lot of controversy.

Please drop the patent topic, it hasn't been relevant for years. If
you search the LKML archives for the initial release of Adeos, you
will see a thread where that specific topic is cleared up. If still
in doubt, do read the actual relevant patent application(s?), you
will see that no nanokernel/hyervisor out there fits the described
method. Not to mention that hypervisors/nanokernels have been there
for decades ... The specific patent that covers dual-kernels does
not even attempt to claim it covers the broad world of nanokernels/
hypervisors.

Hope this clears this bit, and please don't drag this further. That
particular topic has been debated more than enough, and I've said
what I had to say about it many times already. From that point of
view, I fully agree with you that there's no need to waste people's
time further.

With that said, let's go back to talking about the actual technical
arguments :D

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
