Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSGALSr>; Mon, 1 Jul 2002 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGALSq>; Mon, 1 Jul 2002 07:18:46 -0400
Received: from unthought.net ([212.97.129.24]:26590 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S315451AbSGALSp>;
	Mon, 1 Jul 2002 07:18:45 -0400
Date: Mon, 1 Jul 2002 13:21:11 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: michael@insulin-pumpers.org,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Message-ID: <20020701112111.GB18580@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	michael@insulin-pumpers.org,
	Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-raid@vger.kernel.org
References: <200206302046.g5UKkgpS006815@ns2.is.bizsystems.com> <200207011207.07552.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200207011207.07552.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 12:07:07PM +0200, Roy Sigurd Karlsbakk wrote:
...
> 
> I've read the fscking manual - all I can find - for both grub and lilo, and 
> I've tried all possible configurations I can think of.
> 
> point is - I beleive there's a BIOS/linux misunderstanding somewhere

Did you try the   raid-extra-boot  option for LILO ?  I really don't
know if this is the problem you are seeing, but it's worth a shot I
think.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
