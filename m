Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbQKLAc6>; Sat, 11 Nov 2000 19:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbQKLAct>; Sat, 11 Nov 2000 19:32:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:42509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129723AbQKLAcf>; Sat, 11 Nov 2000 19:32:35 -0500
Message-ID: <3A0DE517.3EAF1099@transmeta.com>
Date: Sat, 11 Nov 2000 16:32:23 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001109113524.C14133@animx.eu.org> <m1g0kycm0x.fsf@frodo.biederman.org> <8ukaeb$eh6$1@cesium.transmeta.com> <m13dgycaqh.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Hmm.  You must mean similiar to milo.
> 
> Have fun.  With linuxBIOS I'm working exactly the other way.  Killing
> off the BIOS.  And letting the initial firmware be just a boot loader.
> The reduction is complexity should make it more reliable.
> 

... except that you have to handle every single motherboard architecture
out there now.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
