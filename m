Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVLUTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVLUTXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLUTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:23:08 -0500
Received: from mail.gmx.de ([213.165.64.21]:49317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751188AbVLUTXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:23:06 -0500
X-Authenticated: #26200865
Message-ID: <43A9AB8E.7010802@gmx.net>
Date: Wed, 21 Dec 2005 20:22:54 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: =?ISO-8859-15?Q?Hanno_B=F6ck?= <mail@hboeck.de>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Karol Kozimor <sziwan@hell.org.pl>,
       Christian Aichinger <Greek0@gmx.net>
Subject: Re: [ACPI] Re: asus_acpi still broken on Samsung P30/P35
References: <200512211611.51977.mail@hboeck.de> <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512211035370.4827@g5.osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds schrieb:
> 
> On Wed, 21 Dec 2005, Hanno Böck wrote:
> 
>>This is not "some minor issue", this completely breaks the usage of current 
>>vanilla-kernels on certain Hardware. Can please, please, please anyone in the 
>>position to do this take care that this patch get's accepted before 2.6.15?
>>
>>The patch is available inside mm-sources or here:
>>http://www.int21.de/samsung/p30-2.6.14.diff
>>
>>If I should send it to anyone else or if there's anything I can do to help 
>>fixing this, I'm glad to help.
> 
> 
> Last I saw this patch, I wrote this reply (the patch above is still 
> broken). Nobody ever came back to me on it.
> [...]

I've been busy trying to gather all the different DSDTs to compare
them and find out if the logic can be simplified. Will try to come
up with a patch addressing all your and Andrew's concerns until friday.

Regards,
Carl-Daniel
