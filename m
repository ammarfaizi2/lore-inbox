Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280902AbRKCAzg>; Fri, 2 Nov 2001 19:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280904AbRKCAz0>; Fri, 2 Nov 2001 19:55:26 -0500
Received: from [216.234.199.96] ([216.234.199.96]:7177 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S280902AbRKCAzS>;
	Fri, 2 Nov 2001 19:55:18 -0500
Message-ID: <3BE33E8D.9090405@zianet.com>
Date: Fri, 02 Nov 2001 17:47:09 -0700
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: emu10k emits buzzing and crackling
In-Reply-To: <20011101200955.A1913@redhat.com> <3BE25511.3080708@zianet.com> <004f01c163ad$ef8705a0$0c00a8c0@diemos> <20011102095727.D3662@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is my startup:

Creative EMU10K1 PCI Audio Driver, version 0.16, 14:36:54 Oct 27 2001
emu10k1: EMU10K1 rev 4 model 0x21 found, IO at 0x1c00-0x1c1f, IRQ 16
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)

I should also mention this is kernel 2.4.13 with the latest cvs emu10k1 
driver.
I have no problems with it.

Benjamin LaHaise wrote:

>On Fri, Nov 02, 2001 at 08:52:03AM -0600, Paul Fulghum wrote:
>
>>I'm seeing something similar on RH7.2 with the emu10K driver.
>>Except XMMS and the cd player result in nothing but noise, but
>>the window manager events sound fine. The volume of noise
>>from XMMS/CD player can be controlled by the mixer.
>>
>
>That's very interesting as the driver shipped with rh7.2 works fine on 
>my card.  Are they different revisions of the card?  Could you post your 
>startup logs for the driver -- perhaps we can find some pattern to this 
>and make some kind of quirks mapping.
>
>		-ben
>



