Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSI1LIr>; Sat, 28 Sep 2002 07:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSI1LIr>; Sat, 28 Sep 2002 07:08:47 -0400
Received: from [203.117.131.12] ([203.117.131.12]:17306 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261218AbSI1LIq>; Sat, 28 Sep 2002 07:08:46 -0400
Message-ID: <3D958EF5.7080300@metaparadigm.com>
Date: Sat, 28 Sep 2002 19:13:57 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: felix.seeger@gmx.de
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: System very unstable
References: <200209281155.32668.felix.seeger@gmx.de>	<20020928.025900.58828001.davem@redhat.com>	<200209281233.21897.felix.seeger@gmx.de> <20020928.033510.40857147.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/02 18:35, David S. Miller wrote:
>    From: Felix Seeger <felix.seeger@gmx.de>
>    Date: Sat, 28 Sep 2002 12:33:21 +0200
>    
>    What card is good (performance for games and 
>    a acceptable licenze for kernel developers)?
> 
> ATI Radeon is pretty fast and all except the very latest chips have
> opensource drivers.

Radeon 7500 is currently the fastest board with an opensource
driver that supports 3D. 8500 XFree support is currently 2D only,
although apparently work on the opensource GL driver is underway.

You can get 3D support for the 8500 if you get a commercial
binary only X server ( http://www.xig.com/ ) - although I
guess this is almost as bad as having a binary kernel module
due to the type of hardware access the X server needs to do.

I have a 7500 mobility in my IBM laptop. Stable and fast -
get about 90fps playing tuxracer.

The desktop version of the 7500 is evidentally is about the
same performance as a Geforce2Ti - which is not bad.

ATI has also just released the 9700 which beats the pants
of the fastest Nvidia, if only their was XFree support.

~mc

