Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbREXJJo>; Thu, 24 May 2001 05:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbREXJJf>; Thu, 24 May 2001 05:09:35 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:28423 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S263431AbREXJJ0>; Thu, 24 May 2001 05:09:26 -0400
Message-Id: <200105240909.f4O99ie01182@collie.ncptiddische.net>
Content-Type: text/plain; charset=US-ASCII
From: Nils Holland <nils@nightcastleproductions.org>
Organization: NightCastle Productions
To: Peter Rasmussen <plr@udgaard.com>
Subject: Re: Bug in chipset or feature in kernel?
Date: Thu, 24 May 2001 11:09:44 +0200
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <200105240726.JAA00325@udgaard.com>
In-Reply-To: <200105240726.JAA00325@udgaard.com>
Cc: linux-kernel@vger.kernel.org
NCP-Opt: Powered by Linux
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 May 2001 09:26, Peter Rasmussen wrote:
> Is the below described problem a problem with my chipset, the memory
> subsystem in the kernel, a combination of those or something entirely
> different?
>
> Is there any test I should perform to investigate further eg. to find a
> workaround for a chipset limitation, if that is the problem? It looks as if
> there is a tuning for max. performance around 128MB. Coincidence?

I'm not sure about this as I have never had to deal with something like that 
myself. However, I think that when adding more RAM, you should also add more 
Cache to your system - otherwise performance may drop as described by you. 
Don't ask me, though, how one is supposed to add more cache to a mainboard...

If my above assumption is not right, I hope that someone will share the 
actual facts with you and me ;-)

Greetings
Nils

-- 
----------------------------------------------------------
Nils Holland - nils@nightcastleproductions.org
NightCastle Productions - Linux in Tiddische, Germany
http://www.nightcastleproductions.org
"They asked me where this earthquake would begin,
 I offered to let them feel my pulse."
----------------------------------------------------------
