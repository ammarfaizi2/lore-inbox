Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWA0Omk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWA0Omk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWA0Omk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:42:40 -0500
Received: from darla.ti-wmc.nl ([217.114.97.45]:24462 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S1751459AbWA0Omj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:42:39 -0500
Message-ID: <43DA3155.2060902@ti-wmc.nl>
Date: Fri, 27 Jan 2006 15:42:29 +0100
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Organization: WMC
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>,
       Simon Oosthoek <simon.oosthoek@ti-wmc.nl>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk> <43DA2795.707@ti-wmc.nl> <20060127141850.GC65793@dspnet.fr.eu.org>
In-Reply-To: <20060127141850.GC65793@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Fri, Jan 27, 2006 at 03:00:53PM +0100, Simon Oosthoek wrote:
>> If I'd want to contribute code to the kernel, I'd have to comply with 
>> the license of the kernel, which is v2 of the GPL. If I would actually 
>> prefer my code to be licensed under v3 or higher, I'd have to specify 
>> that my code is only licensed under v2 for the kernel to humour Linus 
>> Torvalds and respect the license of the kernel, but in all other ways 
>> the code is used, I only grant a license to copy under the conditions of 
>> the GPL v3 or higher. I don't see why that would affect the distribution 
>> of the kernel at all.
> 
> "GPLv2 only for the kernel" is a different license than "GPLv2" and is
> incompatible with GPLv2.
>

hmm, so if I want to contribute to the kernel, but prefer my code to be 
licensed under GPLv3 or higher, I would be unable to submit it to the 
kernel unless I "lower my standards" to GPLv2 or higher?

If someone wants to use that code elsewhere, he can take it from the 
kernel and re-use it in a GPLv2 project and further, which may violate 
the terms of GPLv3 and would therefore conflict with my interests.

Of course, this may be purely theoretical, but it could block people 
from submitting code to the kernel in order avoid the v2 GPL license.

 From this, I think it could be concluded that it might turn out to be 
quite harmful if code under GPLv3+ cannot be combined with the linux 
kernel...

/Simon

PS, IANAL
