Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286816AbRLVQPB>; Sat, 22 Dec 2001 11:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286808AbRLVQOw>; Sat, 22 Dec 2001 11:14:52 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9740 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S286814AbRLVQOk>;
	Sat, 22 Dec 2001 11:14:40 -0500
Date: Sat, 22 Dec 2001 17:14:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011222171438.A10233@suse.cz>
In-Reply-To: <20011221141847.E15926@redhat.com> <E16Ha5u-00027A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Ha5u-00027A-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 22, 2001 at 12:32:54AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 12:32:54AM +0000, Alan Cox wrote:
> > by the MB, everyone talks about MB == 1024*1024...  I'm having a 
> > hard time giving a sympathetic ear to anyone try to change the well 
> > established, and consistent (barring the storage venduhs), standard.
> 
> If someone sells you 16MB of RAM and it turns out to be 16,000,000 bytes,
> not only would it be appropriate use of units, it would be quite reasonable
> as far as I can see to say it was in accordance with labelling of products.
> 
> The world did not begin in 1970, A-Za-z is not English collate order and
> M is 1,000,000. When computing meets the rest of planet earth usages for
> the odd hundred years its hard to see any reason to believe we are "right"
> 
> Eric using MiB seems the right thing. Its an ugly but appropriate unit, its
> at least recommended as a solution by a standards body. We can either
> redefine SI units ("You cannot change the laws of physics") or find a better
> label. What better than a recommended one others use.

The only problem is that M = 10^6 plus Mi = 2^20 don't cover the usages ...

4Mbit bandwidth is usually 4 * 10^3 * 2^10 bits per second.
20GB harddrive is usually 20 * 10^6 * 2^10 bytes.

The confusion is there. It can't be erradicated by adding Mi's and Gi's,
because they don't cover the whole spectrum.

Well, maybe we could have a 4 kKib/s connection and a 20 MKiB drive, but
that'd be even more confusing than what we have now.

-- 
Vojtech Pavlik
SuSE Labs
