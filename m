Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132380AbRAXROo>; Wed, 24 Jan 2001 12:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbRAXROg>; Wed, 24 Jan 2001 12:14:36 -0500
Received: from [203.169.151.222] ([203.169.151.222]:35345 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S131240AbRAXROS>;
	Wed, 24 Jan 2001 12:14:18 -0500
Message-ID: <3A6F0D6B.34EB2CB0@coppice.org>
Date: Thu, 25 Jan 2001 01:14:19 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Probably Off-topic Question...
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Olsen wrote:
> 
> This is probably a user-land and/or undocumented thing, but I am not
> certain where to get the correct info.
> 
> Does anyone know how to get the screen brightness control to work on a
> Sony Vaio N505VE?  There seems to be some sort of proprietary hook to get
> it to work that requires their install of Windows.  (This is a problem as
> it was removed immediatly after purchacing the laptop.)

All the newer Vaios seem to have this problem. They rely on support from
Windows to control the brightness, instead of doing it through the BIOS,
like older machines. I don't know a solution. More annoyingly, they
won't hibernate, as they rely on Windows Me or 2000 doing it for them.
The APM hibernate in the BIOS seems to have gone. I have a Z505GAT,
which I think is the Asian version of the model sold in the US as the
Z505LE. I guess this will become the norm now none of the current
versions of Windows require any hibernation support from the BIOS. The
hibernate to swap patch for Linux really needs to get into the
mainstream, and be more thoroughly exercised.

> And as for code comments, they should be written in Ancient Greek with
> code examples taken from APL and BCPL and written using the ISO character
> set for Sanscrit.  (To avoid complaints of swear words appearing in them
> by the morally clenched.)

If they aren't in ASCII, they don't follow the C standard.

Regards,
Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
