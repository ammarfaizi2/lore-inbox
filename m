Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132257AbRCZA2w>; Sun, 25 Mar 2001 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRCZA2m>; Sun, 25 Mar 2001 19:28:42 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:49720 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S132257AbRCZA2i>; Sun, 25 Mar 2001 19:28:38 -0500
Message-Id: <4.3.2.7.2.20010325162459.00b54620@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 25 Mar 2001 16:27:37 -0800
To: linas@linas.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: mouse problems in 2.4.2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010325223358.71E5F1B7A4@backlot.linas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing the same thing with an ASUS P5A-B running a K6-2/266 with 
Linux 2.2.17, and Windows 98.   Central problem appears to be the KVM 
switch I'm using. Save yourself the problem.

I had to reboot all the systems to get regular mouse operation back with 
the Logitech.

Satch


At 04:33 PM 3/25/01 -0600, you wrote:
>I am experiencing debilitating intermittent mouse problems & was about
>to dive into the kernel to see if I could debug it.  But first, I thought
>a quick note to the mailing list may help.
>
>Symptoms:
>After a long time of flawless operation (ranging from nearly a week to
>as little as five minutes), the X11 pointer flies up to top-right corner,
>and mostly wants to stay there.  Moving the mouse causes a cascade of
>spurious button-press events get generated.
>
>This did not occur with 2.4.0test2 or 2.2.16 (to the best of my
>recollection) and first showed up in 2.4.0test7 or 2.4.1 (not sure).
>With 2.4.2, the symptoms seem slightly different (almost all pointer
>movement events seem to be lost; although spurious button-press events
>still happen).
>
>Mouse is a logitech trackman marble, with USB connector to
>logitech-supplied USB to ps/2 DIN plug.  Configured as a PS/2 mouse.
>Motherboard is a Athalon/VIA Apollo KA7.

