Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288026AbSABXgZ>; Wed, 2 Jan 2002 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbSABXe6>; Wed, 2 Jan 2002 18:34:58 -0500
Received: from tourian.nerim.net ([62.4.16.79]:21775 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S287972AbSABXdz>;
	Wed, 2 Jan 2002 18:33:55 -0500
Message-ID: <3C3398E1.4080904@free.fr>
Date: Thu, 03 Jan 2002 00:33:53 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102174824.A21408@thyrsus.com> <E16LubO-0005xF-00@the-village.bc.nu> <20020102180754.A21788@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> 
>>>(Telling me to rely on dmidecode already being installed SUID is not
>>>a good answer either.  No prizes for figuring out why.)
>>>
>>Well you can't rely on the kernel having the modification either. 
>>
> 
> If /proc/dmi were to go in soon, at least I *could* rely on it in 2.6.
> 

If in rc.sysinit a call to "dmidecode > /var/run/dmi" were to go in the 
user space 2.6 kernel build dependancies in Documentation/Changes, 
you'll be on the same level.


