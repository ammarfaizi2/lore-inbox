Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbRGCI1c>; Tue, 3 Jul 2001 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbRGCI1W>; Tue, 3 Jul 2001 04:27:22 -0400
Received: from femail6.sdc1.sfba.home.com ([24.0.95.86]:40439 "EHLO
	femail6.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S265594AbRGCI1T>; Tue, 3 Jul 2001 04:27:19 -0400
Message-Id: <5.1.0.14.2.20010703082546.01c5eae0@mail.abac.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Jul 2001 08:28:10 -0700
To: Christopher Yeoh <cyeoh@samba.org>
From: Android <android@abac.com>
Subject: Re: [PATCH] more penguins
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15169.30616.190474.603946@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Here's a patch against 2.4.5 so we can display a decent number of
>penguins at boot time (wraps the display of the boot penguins when
>they can't all fit on one line).
>
>Chris.

What is the point of displaying penguins in framebuffer mode if it is going
to change the video mode set by the vga= command line parameter?
I like to set my display to 50 lines. This won't stay when the penguin 
comes up.
In standard character mode, this isn't a problem. So, how do we fix this?
Is there a command line parameter that prevents the penguin logo from 
coming up?

                           -- Ted


