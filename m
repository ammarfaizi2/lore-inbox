Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282114AbRK1KRc>; Wed, 28 Nov 2001 05:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282103AbRK1KRX>; Wed, 28 Nov 2001 05:17:23 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41477 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282114AbRK1KRF>; Wed, 28 Nov 2001 05:17:05 -0500
Message-ID: <3C04B750.AC70B357@evision-ventures.com>
Date: Wed, 28 Nov 2001 11:07:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: sebastian.droege@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
In-Reply-To: <20011127204819Z282941-17408+21242@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Dröge wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> ok
> I've corrected it myself I think
> The patch is attached
> Hopefully it doesn't break something :)
> It's my first patch so please don't kill me
> Bye

You patch is reverted and I don't think it will cut it,
since I tries this myself and it didn't work out.

BTW>. Anybody out there who managed to make
SCSI gogin on 2.5.1-pre2... I only have PPA ZIP and
IDE-SCSI at my home machine, and both fail with a bad
pointer derefference...
