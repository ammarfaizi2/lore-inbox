Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUG1Ren@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUG1Ren (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUG1Rem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:34:42 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:15746
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S266837AbUG1Rek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:34:40 -0400
Message-ID: <4107E3AB.2000703@freemail.hu>
Date: Wed, 28 Jul 2004 19:34:35 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Sym53C896: CACHE INCORRECTLY CONFIGURED
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 27 Jul 2004 10:45:57 +0300 (EEST)
> Meelis Roos <mroos@linux.ee> wrote:
> 
>> I got a 53c896 dual channel 64-bit PCI card (Compaq series EOB003). Tried
>> it in x86 (i815 mainboard) and Sun Ultra 5 (both with 32-bit PCI slots).
>> Both errored out basically the same way (this is from the PC, Linux
>> 2.6.8-rc2):
> 
> I think your card is toast, if it fails like this it means that
> even the most basic script cannot execute on the onboard processor.

You may have hope, though. I also had this error on my
Diamond Fireport 40 (53c875j) some time back.
Blowing out the dust from the PSU helped. :-)

Best regards,
Zoltán Böszörményi


