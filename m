Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRL0OUG>; Thu, 27 Dec 2001 09:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281738AbRL0OTz>; Thu, 27 Dec 2001 09:19:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:37894 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S286313AbRL0OTp>; Thu, 27 Dec 2001 09:19:45 -0500
Date: Thu, 27 Dec 2001 15:19:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Message-ID: <20011227151940.A15022@suse.cz>
In-Reply-To: <E16Ha5u-00027A-00@the-village.bc.nu> <alan@lxorguk.ukuu.org.uk> <20011221141847.E15926@redhat.com> <E16Ha5u-00027A-00@the-village.bc.nu> <20011222171438.A10233@suse.cz> <8FeKhAhXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8FeKhAhXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Thu, Dec 27, 2001 at 12:45:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 12:45:00PM +0200, Kai Henningsen wrote:
> vojtech@suse.cz (Vojtech Pavlik)  wrote on 22.12.01 in <20011222171438.A10233@suse.cz>:
> 
> > The only problem is that M = 10^6 plus Mi = 2^20 don't cover the usages ...
> >
> > 4Mbit bandwidth is usually 4 * 10^3 * 2^10 bits per second.
> > 20GB harddrive is usually 20 * 10^6 * 2^10 bytes.
> 
> There's a simple answer. "These people lie."

Ok, then how *you* would call the abovementioned link that has 4096000
bits per second bandwidth? Yes, it's possible to say 4096 kbit, but then
you'll also have 32768 kbit links and 8388608 kbit links ...

> > The confusion is there. It can't be erradicated by adding Mi's and Gi's,
> > because they don't cover the whole spectrum.
> 
> We don't *want* something that covers that part of the spectrum. We want  
> that part to be *avoided*.

But how do you avoid something that *exists*? I mean - physically. The
devices that are described by these numbers are being produced and used.

-- 
Vojtech Pavlik
SuSE Labs
