Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSAQWiy>; Thu, 17 Jan 2002 17:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290511AbSAQWip>; Thu, 17 Jan 2002 17:38:45 -0500
Received: from freeside.toyota.com ([63.87.74.7]:20996 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290502AbSAQWid>; Thu, 17 Jan 2002 17:38:33 -0500
Message-ID: <3C47525B.7070108@lexus.com>
Date: Thu, 17 Jan 2002 14:38:19 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020114
X-Accept-Language: en-us
MIME-Version: 1.0
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: hangs using opengl
In-Reply-To: <20020117191450.932B64ADB4@drie.kotnet.org>		<3C47284A.9080607@kabelfoon.nl>	 <1011300289.32057.18.camel@zeus> 	<3C473A57.3000206@lexus.com>	<1011302680.639.12.camel@zeus>  <3C47429B.7060306@lexus.com> <1011305059.614.31.camel@zeus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reid Hekman wrote:

>On Thu, 2002-01-17 at 15:31, J Sloan wrote:
>
>>BTW I did notice some longish pauses
>>during RtCW when using nv agp, so I
>>am using the in-kernel agp....
>>
>
>Hmm, it's fine here. What chipset and video card are you using? I've
>been looking at Athlon boards and I'm curious about issues showing up in
>AGP, IDE, PCI among the various platforms -- specifically AMD and Via
>(maybe SiS too).
>
I'm using a PIII-933 on an i815 mobo.

Video card recently upgraded from a
voodoo3 to a geforce mx 200 -

It seems rock solid; the box is doing a
number of things - iptables for the home
lan, web/mail/dns/ftp etc; I use it as a
workstation/game box when I'm home -


lspci output if interested -

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 02)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 02)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 02)
01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 01)
01:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)01:0d.0 Multimedia audio controller: Ensoniq ES1371 
[AudioPCI-97] (rev 06)
02:00.0 VGA compatible controller: nVidia Corporation NV11 DDR (rev b2)


