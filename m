Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVBXAao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVBXAao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVBXA3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:29:40 -0500
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:20710 "EHLO
	garfield") by vger.kernel.org with ESMTP id S261736AbVBXA1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:27:18 -0500
Message-ID: <421D1F4F.5060508@free.fr>
Date: Thu, 24 Feb 2005 01:26:55 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 MultiZilla/1.6.4.0b
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>
CC: Ed Tomlinson <tomlins@cam.org>, "J.A. Magallon" <jamagallon@able.es>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
References: <20050223014233.6710fd73.akpm@osdl.org> <1109198320l.7018l.0l@werewolf.able.es> <200502231812.07882.tomlins@cam.org> <200502231840.06017.dtor_core@ameritech.net>
In-Reply-To: <200502231840.06017.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov a ecrit le 24.02.2005 00:40:

> On Wednesday 23 February 2005 18:12, Ed Tomlinson wrote:
> 
>> On Wednesday 23 February 2005 17:38, J.A. Magallon wrote:
>> 
>>> On 02.23, Andrew Morton wrote:
>>> 
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
>>>> 
>>>> - Various fixes and updates all over the place.  Things seem to
>>>>  have slowed down a bit.
>>>> 
>>>> - Last, final, ultimate call: if anyone has patches in here 
>>>> which are 2.6.11 material, please tell me.
>>> 
>>> Two points:
>>> 
>>> - I lost my keyboard :(. USB, but plugged into PS/2 with an 
>>> adapter.
>> 
>> Mine too.  Details sent in another message...
> 
> Does i8042.nopnp help?

yes, keyboard is back


Andrew Morton a ecrit le 24.02.2005 00:25:

> Ed Tomlinson <tomlins@cam.org> wrote:
> 
>> It does not seem to be finding the keyboard at all...
> 
> Can you confirm that Linus's tree is OK?  You'd best use the patch at
>  http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ to make 
> sure you have the latest stuff.

2.6.11-rc4 +
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-20050223_2308.txt.gz
is indeed ok :

Feb 24 01:08:23 odie kernel: Kernel command line: 
BOOT_IMAGE=2.6.11-rc4-ff ro root=305 hdd=ide-scsi
[...]
Feb 24 01:08:23 odie kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0


Thank you,
Fabian
