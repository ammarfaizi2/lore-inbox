Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBDABZ>; Mon, 3 Feb 2003 19:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBDABY>; Mon, 3 Feb 2003 19:01:24 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:12972 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267023AbTBDABY>; Mon, 3 Feb 2003 19:01:24 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
References: <20030202223009.GA344@elf.ucw.cz> 
	<200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Feb 2003 00:10:47 +0000
Message-Id: <1044317447.27957.63.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: Compactflash cards dying?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 23:56, Roger Larsson wrote:
> On Sunday 02 February 2003 23:30, Pavel Machek wrote:
> > I had compactflash from Apacer (256MB), and it started corrupting data
> > in few months, eventually becoming useless and being given back for
> > repair. They gave me another one and it is just starting to corrupt
> > data.
> 
> That is very bad... I wonder if you do something that the CF does
> not like - like power off while writing (can actually destroy the
> disk - read in some newsgroup)

I am led to believe that this is normal for CompactFlash. I seem to
recall that the phrase 'bogroll technology' was used by the last person
to attempt any serious testing.

It's fine for short-term storage of stuff like digital photos, but don't
try using it for long-term storage. Think of it like a floppy disc -- if
you have any _important_ data, make sure it's backed up or copied onto
at least three of them to avoid loss.

Not that there's any _fundamental_ reason why PCMCIA-ATA should be
completely unreliable, that just seems to be the way it's done.
Reliability costs, you see.

-- 
dwmw2

