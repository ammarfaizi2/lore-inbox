Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSI2FpX>; Sun, 29 Sep 2002 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSI2FpX>; Sun, 29 Sep 2002 01:45:23 -0400
Received: from [203.117.131.12] ([203.117.131.12]:36568 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262394AbSI2FpW>; Sun, 29 Sep 2002 01:45:22 -0400
Message-ID: <3D9694AC.9020907@metaparadigm.com>
Date: Sun, 29 Sep 2002 13:50:36 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Elladan <elladan@eskimo.com>
Cc: felix.seeger@gmx.de, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: System very unstable
References: <200209281155.32668.felix.seeger@gmx.de> <20020928.025900.58828001.davem@redhat.com> <200209281233.21897.felix.seeger@gmx.de> <20020928.033510.40857147.davem@redhat.com> <3D958EF5.7080300@metaparadigm.com> <20020929000056.GB19765@eskimo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/02 08:00, Elladan wrote:
> On Sat, Sep 28, 2002 at 07:13:57PM +0800, Michael Clark wrote:
> 
>>On 09/28/02 18:35, David S. Miller wrote:
>>
>>>  From: Felix Seeger <felix.seeger@gmx.de>
>>>  Date: Sat, 28 Sep 2002 12:33:21 +0200
>>>  
>>>  What card is good (performance for games and 
>>>  a acceptable licenze for kernel developers)?
>>>
>>>ATI Radeon is pretty fast and all except the very latest chips have
>>>opensource drivers.
>>
>>Radeon 7500 is currently the fastest board with an opensource
>>driver that supports 3D. 8500 XFree support is currently 2D only,
>>although apparently work on the opensource GL driver is underway.
> 
> 
> Unfortunately, in my experience the open source Radeon 7500 drivers are
> so unstable as to be basically unusable.  Plus, they seem to still be
> basically incompatible with a lot of 3d software.

Don't know what version of X you've been running, but i haven't
had a problem for over 8 months (since XFree86 4.2). Before then,
the 4.1.99 CVS was needed for radeon support which was of course
a developer branch, although i never experienced the sort of problems
you describe.

Definately rock solid and stable on my 7500 mobility.

~mc

