Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVGGTh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVGGTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVGGTdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:33:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39948 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262055AbVGGTbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:31:17 -0400
Message-ID: <42CD83B6.4010004@tmr.com>
Date: Thu, 07 Jul 2005 15:34:14 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_To?= =?ISO-8859-1?Q?mt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <200507042033.XAA19724@raad.intranet> <42C9C56D.7040701@tomt.net>	 <42CA5A84.1060005@rainbow-software.org>	 <20050705101414.GB18504@suse.de>	 <42CA5EAD.7070005@rainbow-software.org> <42CC4589.8060509@tmr.com> <58cb370e05070706485276333@mail.gmail.com>
In-Reply-To: <58cb370e05070706485276333@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> BIOS setting is irrelevant and ~14MB/s for UDMA33 is OK.
> CPU cycles are wasted somewhere else...

After seeing how poorly Linux copes with bad info coming out of ACPI, I 
no longer assume that BIOS information is ignored. Thought it was worth 
mentioning.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
