Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWDCRw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWDCRw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWDCRw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:52:57 -0400
Received: from [69.90.147.196] ([69.90.147.196]:42456 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1750897AbWDCRw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:52:57 -0400
Message-ID: <443162B4.60500@kenati.com>
Date: Mon, 03 Apr 2006 11:00:20 -0700
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch for AICA sound support on SEGA Dreamcast
References: <1144075522.11511.20.camel@localhost.localdomain> <s5hvetqac7i.wl%tiwai@suse.de>
In-Reply-To: <s5hvetqac7i.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>Please avoid use of typedefs as much as possible.
>We (finally :-) got rid of whole typedefs recently from the ALSA core
>code.
>
>  
>
Hi Takashi,

Just out of curiosity. What is the reason for no using typedefs ?

Thanks,


Carlos Munoz
