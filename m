Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280708AbRKBOwR>; Fri, 2 Nov 2001 09:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280711AbRKBOwI>; Fri, 2 Nov 2001 09:52:08 -0500
Received: from www.microgate.com ([216.30.46.105]:40975 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S280708AbRKBOv6>; Fri, 2 Nov 2001 09:51:58 -0500
Message-ID: <004f01c163ad$ef8705a0$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Benjamin LaHaise" <bcrl@redhat.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011101200955.A1913@redhat.com> <3BE25511.3080708@zianet.com>
Subject: Re: emu10k emits buzzing and crackling
Date: Fri, 2 Nov 2001 08:52:03 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>One of the workstations I use really doesn't like the emu10k driver in 
>2.4.13-ac5.  The box is a dual athlon running rh7.2.  Playing mp3s seems 
>to work well, but other samples from xfce on shutdown and window close 
>result in buzzing and popping noises.  If anyone wants details or patches 
 >tested, drop me a note.

I'm seeing something similar on RH7.2 with the emu10K driver.
Except XMMS and the cd player result in nothing but noise, but
the window manager events sound fine. The volume of noise
from XMMS/CD player can be controlled by the mixer.

Machine is a dual P3-450, GX chip set.

I saw this with both the base RH7.2 kernel and the latest RH
kernel (2.4.9-??). RH 7.1 worked fine on the same hardware.
I tried playing with mixer settings and IRQ settings with no difference.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com

