Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284143AbRLKWmj>; Tue, 11 Dec 2001 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284141AbRLKWm3>; Tue, 11 Dec 2001 17:42:29 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:3335 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S284143AbRLKWmV>; Tue, 11 Dec 2001 17:42:21 -0500
Date: Tue, 11 Dec 2001 22:41:04 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid success with 2.4.17-pre8. Intentional?
Message-ID: <20011211224104.B256@butterlicious.bodgit-n-scarper.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011211150717.A20308@mould.bodgit-n-scarper.com> <E16DvOC-0006wF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16DvOC-0006wF-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.13 on i686 (butterlicious)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 10:28:40PM +0000, Alan Cox wrote:
> > I've just tried the latest 2.4.17-pre8 kernel, and it works, in that
> > it gets passed the fsck'ing. I couldn't see anything in the changelog that
> > screamed "Fix fsck hang with aacraid", so I was wondering if my working
> > setup is intentional or not? I haven't followed the development of this
> > driver too closely, I just had the card and downloaded the latest "stable"
> > release and went from there...
> 
> The later fixes I applied (and Matt Domsch's fixes too) don't really do
> anything that would explain this.

That was what I was afraid of. :-)

The only other kernel that I have tried was 2.4.7, from a Slackware 8.0
bootdisk, found at http://www.alphacent.com/opensource, which I needed to use
to be able to install the system. I then used this kernel as a temporary
measure for booting, no problems with it either, but I guess a lot has
changed since then...

Is there anything I can do to help? I can provide the kernel config if that
would be useful, (I can't get at it until tomorrow morning), which is the same
one I used on all three kernel builds. The box isn't in production use,
(funny, that), so I can run some tests if needs be.

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"
