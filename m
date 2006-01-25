Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWAYTvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWAYTvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAYTvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:51:21 -0500
Received: from smtpout.mac.com ([17.250.248.73]:60915 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751139AbWAYTvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:51:20 -0500
In-Reply-To: <43D7D05D.7030101@perkel.com>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net> <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Wed, 25 Jan 2006 14:50:43 -0500
To: Marc Perkel <marc@perkel.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2006, at 14:24:13, Marc Perkel wrote:
> Is it possible to have Linux be mostly GPL3 with parts of it GPL2?  
> Or is that just too insane to deal with?

Well given that parts of the kernel are GPLv2-only, other parts are  
GPLv2+, other parts are GPL/BSD, etc, I can't see how somebody using  
a GPLv3-only or GPLv3+ license for some other part would be  
problematic.  If anything, the multiple licensing provides additional  
code protection; we get the advantages of all the licenses, but if  
any one license is found to be invalid, it does not break the  
protection of the body of code itself.

Cheers,
Kyle Moffett

