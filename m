Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSHGF5A>; Wed, 7 Aug 2002 01:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHGF5A>; Wed, 7 Aug 2002 01:57:00 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:45798 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S317006AbSHGF47> convert rfc822-to-8bit;
	Wed, 7 Aug 2002 01:56:59 -0400
Date: Wed, 7 Aug 2002 08:00:35 +0200
Message-Id: <200208070600.g7760Zj04875@eday-fe2.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
To: jeffchua@silk.corp.fedex.com
Subject: Re: Sv: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 170218535e1c5f5847581e0e4b55594662515f4f12524912554e5545495c51491d5b88
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm afraid even that didn't help much - Only now I get a different kind
>> of error... Before, trying to play a sound, the operation would just
>> fisish immediatelyand a few noises were heard in the speakers... Now the
>> operation never finishes - still no sound... and I found these error
>> messages in dmesg..
>
>one last try ...
>
>unload all network, scsi, modems. Bare minimum and see if the sound alone
>would work. Again, use "aumix" before playing anything.
>
>Jeff
>

Same situation with nothing loaded but the essential modules... heck I even unloaded the cdrom module and it's exactly the same as before... :-(

Thomas



-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

