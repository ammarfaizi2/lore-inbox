Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132366AbRAXRae>; Wed, 24 Jan 2001 12:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRAXRaO>; Wed, 24 Jan 2001 12:30:14 -0500
Received: from winksmith.com ([63.72.148.216]:29476 "EHLO winksmith.com")
	by vger.kernel.org with ESMTP id <S132366AbRAXRaE>;
	Wed, 24 Jan 2001 12:30:04 -0500
Message-ID: <20010124123001.52317@winksmith.com>
Date: Wed, 24 Jan 2001 12:30:01 -0500
From: Mark Smith <mark@winksmith.com>
To: Steve Underwood <steveu@coppice.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Probably Off-topic Question...
Reply-To: mark@winksmith.com
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org> <3A6F0D6B.34EB2CB0@coppice.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <3A6F0D6B.34EB2CB0@coppice.org>; from Steve Underwood on Thu, Jan 25, 2001 at 01:14:19AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 01:14:19AM +0800, Steve Underwood wrote:
> > This is probably a user-land and/or undocumented thing, but I am not
> > certain where to get the correct info.
> > 
> > Does anyone know how to get the screen brightness control to work on a
> > Sony Vaio N505VE?  There seems to be some sort of proprietary hook to get
> > it to work that requires their install of Windows.  (This is a problem as
> > it was removed immediatly after purchacing the laptop.)
> 
> All the newer Vaios seem to have this problem. They rely on support from
> Windows to control the brightness, instead of doing it through the BIOS,
> like older machines. I don't know a solution. More annoyingly, they
> won't hibernate, as they rely on Windows Me or 2000 doing it for them.
> The APM hibernate in the BIOS seems to have gone. I have a Z505GAT,
> which I think is the Asian version of the model sold in the US as the
> Z505LE. I guess this will become the norm now none of the current
> versions of Windows require any hibernation support from the BIOS. The
> hibernate to swap patch for Linux really needs to get into the
> mainstream, and be more thoroughly exercised.

if anyone finds a way of dimming the brightness make sure you post!
besides killing the battery, it also makes it hard to use in dark
places such as night flights.  i feel as if i'm lighting up the
cabin in these cases.

my vaio F-series used to sleep correctly under RH6.1.  it now hangs
forever making the sleep mode much less useful.

-- 
Mark Smith
mark@winksmith.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
