Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbUKVRPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbUKVRPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUKVRGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:06:51 -0500
Received: from mail.convergence.de ([212.227.36.84]:13784 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262230AbUKVRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:02:30 -0500
Message-ID: <41A21B71.8060001@linuxtv.org>
Date: Mon, 22 Nov 2004 18:01:37 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [linux-dvb-maintainer] [patch] 2.6.10-rc2-mm3: DVB: philips_tdm1316l_config
 multiple definition
References: <20041121223929.40e038b2.akpm@osdl.org> <20041122155123.GE19419@stusta.de> <20041122160955.GA18255@convergence.de>
In-Reply-To: <20041122160955.GA18255@convergence.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22.11.2004 17:09, Johannes Stezenbach wrote:
> BTW, like I said in some previous mail I think this "Big DVB update"
> isn't ready for prime time yet. It breaks support for some
> DVB cards (partially fixed in linuxtv.org CVS), so I think
> this should not go into the mainline kernel now. IMHO it's better
> to wait until 2.6.10 is out.
> 
> Michael: Do you think differently?

Nope. But in my mail to Andrew and Linus I said that it shouldn't go 
into 2.6.10 yet, but instead get some testing in -mm.

So Andrew, please hold this in -mm until we have fixed the remaining 
problems. I'll feed with you with update patches.

> Johannes

CU
Michael.
