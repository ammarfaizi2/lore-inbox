Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSGAKEk>; Mon, 1 Jul 2002 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGAKEj>; Mon, 1 Jul 2002 06:04:39 -0400
Received: from [62.70.58.70] ([62.70.58.70]:31366 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314551AbSGAKEi> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 06:04:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: michael@insulin-pumpers.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Mon, 1 Jul 2002 12:07:07 +0200
User-Agent: KMail/1.4.1
References: <200206302046.g5UKkgpS006815@ns2.is.bizsystems.com>
In-Reply-To: <200206302046.g5UKkgpS006815@ns2.is.bizsystems.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207011207.07552.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 June 2002 23:46, Michael wrote:
> > I hope this is not OT - didn't find any LILO mailing list. after
> > trying virtually everything - can anyone help me with a tip?
>
> The problem you're having is not with raid but with LILO in general.
> I don't remember the specifics, but I've experienced the same thing
> and it was an error in how I used lilo or the version of the boot
> record -- something strange like that. Raid is not part of the
> problem.
>
> Read the docs that come with the LILO distribution in the source. The
> man page does not have as much info. You may also be suffering from
> differing version of the MBR -- a major source of pain and suffering.

I've read the fscking manual - all I can find - for both grub and lilo, and 
I've tried all possible configurations I can think of.

point is - I beleive there's a BIOS/linux misunderstanding somewhere

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

