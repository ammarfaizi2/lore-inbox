Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWBBM0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWBBM0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBBM0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:26:04 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:17078 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750960AbWBBM0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:26:02 -0500
Message-ID: <43E1FB8F.5070005@aitel.hist.no>
Date: Thu, 02 Feb 2006 13:31:11 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEplc8O6cyBHYWxsZWdvIEFyaWFz?= 
	<egallego@babel.ls.fi.upm.es>
CC: James Bruce <bruce@andrew.cmu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <87mzha85sc.fsf@babel.ls.fi.upm.es> <43E1E2F2.1090102@andrew.cmu.edu> <87ek2m813t.fsf@babel.ls.fi.upm.es>
In-Reply-To: <87ek2m813t.fsf@babel.ls.fi.upm.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emilio Jesús Gallego Arias wrote:

>James Bruce <bruce@andrew.cmu.edu> writes:
>
>  
>
>>Emilio Jesús Gallego Arias wrote:
>>    
>>
>>>... 1.- Distribute a kernel with some DRM built-in under the GPL.
>>>2.- Claim that such kernel is an effective technological measure to
>>>    protect copyright. 
>>>      
>>>
>>You forgot:
>>
>>2.5- Due to the DMCA, the code now has an additional restriction on
>>     top of what is already in its license, the GPL v2.  The GPL v2
>>     forbids additional restrictions, and thus the resulting work
>>     cannot be distributed.
>>    
>>
>
>Ok, so to add DRM to GPLed software, the copyright holder has to state
>that the DMCA does not apply to such software? Or does the GPL state
>that? 
>  
>
This isn't only about DRM protecting your distributed kernel.
Lets say you want to make a linux-driven home entertainment
device.  And you add DRM - not to protect the kernel you don't
really care about, but in order to use protected content in a
restricted fashion. Perhaps your business also sell DVDs.

Saying that the DRM doesn't apply to the kernel itself won't
help.  Users may, in this case, want to alter the DRM so it
doesn't restrict their use of Cds, DVDs etc.  That however
breaks with the DMCA - even if you allow unrestricted source
code modifications.  So you cannot legally distribute a kernel
with DRM - because DRM comes with a "no tampering" law
which don't work with the GPL.  Businesses can still add
DRM stuff in a proprietary userland app though.

The fact that DMCA law is a restriction imposed by
government rather than the distributor makes no difference.
The distributor implicitly imposes restrictions by linking in DRM sw, just
as the distributor would implicitly impose some restrictions by
linking a proprietary-licenced object into the kernel.

Helge Hafting




>Quoting the GPL:
>
>6.- [...] You may not impose any further restrictions on the recipients'
>  exercise of the rights granted herein. [...]
>
>The point is that it is not the copyright holder who is imposing the
>restrictions, is the law. For example, the law may impose some export
>restrictions, would that void the GPL?
>
>  
>
>>>3.- You are no longer free to modify that kernel, (removing the DRM
>>>      
>>>
>                                 ^^^^^^
>I meant modify and distribute, sorry.
>  
>
>>>[...]
>>>      
>>>
>>If the DRM author(s) are the ones claiming the DRM is an "effective
>>technological measure", then they are the ones imposing an additional
>>    
>>
>
>They are only a claiming, not restricting. The restriction would come
>from the law when a judge decides that the code in question is an
>"effective technological measure".
>  
>
>>restriction.  Those authors are the ones who can be sued, not the end
>>users of the kernel+DRM.  If someone else makes the claim, it carries
>>    
>>
>Ok, I mean a user who tries to exercise all the rights stated in the
>GPL, including distribution of the modified code.
>  
>
>>no weight at all, because they are not the author or copyright owner.
>>    
>>
>
>Regards,
>
>Emilio
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

