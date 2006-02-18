Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWBRVGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBRVGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWBRVGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:06:49 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:32933 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932162AbWBRVGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:06:48 -0500
Message-ID: <43F78C5F.4030504@aitel.hist.no>
Date: Sat, 18 Feb 2006 22:06:39 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       =?UTF-8?B?R2Vycml0IEJydWNoaMOkdXNlcg==?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>,
       =?UTF-8?B?QmrDtnJuIE5pbHNzb24=?= <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>We still have some serious bugs, several of which are in 2.6.15 as well:
>
[...]

>- Helge Hafting reports a usb printer regression - I don't know if that's
>  still live?
>  
>
I tried printing four pages of graphichs with 2.6.16-rc3-mm1
and it worked fine.  When I had the problem I couldn't even print
three, I had to print the 10 pages I needed one by one.

So I believe the situation has improved.

Helge Hafting

