Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRCDSS7>; Sun, 4 Mar 2001 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130488AbRCDSSt>; Sun, 4 Mar 2001 13:18:49 -0500
Received: from alto.i-cable.com ([210.80.60.4]:6606 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S130487AbRCDSSl>;
	Sun, 4 Mar 2001 13:18:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Lau <lkthomas@hkicable.com>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: How can I get promise FastTrak 66 work in kernel?
Date: Mon, 5 Mar 2001 02:34:45 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10103041307450.14959-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10103041307450.14959-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01030502344501.97230@cm61-18-16-156.hkcable.com.hk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 March 2001 18:08, you wrote:
> > anyone have idea?
>
> it does work.
>
> > I mean kernel 2.4.1
>
> why?  use a more recent one, like 2.4.2-ac11.
Hi, well
he is using RAID card !
his 2.2.x promise hacked modules work fine, but I didn't install that old 
modules, it's not support SCSI emulator

well, if using 2.2.x hacked kernel, it can tell out that HD are SCSI HD ( 
sda0 ), but in 2.4.x, it's display ( hde ) and can not boot up to linux!
what's problem is it??
