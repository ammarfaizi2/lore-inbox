Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSEFLiR>; Mon, 6 May 2002 07:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSEFLiQ>; Mon, 6 May 2002 07:38:16 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41107 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S310637AbSEFLiQ>; Mon, 6 May 2002 07:38:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Mike Black" <mblack@csihq.com>
Date: Mon, 6 May 2002 21:37:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15574.27397.604248.250447@notabene.cse.unsw.edu.au>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.14 compile error
In-Reply-To: message from Mike Black on Monday May 6
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 6, mblack@csihq.com wrote:
> Is RAID1/5 support even safe in the current 2.5 series?  I saw Neil post a
> message while ago but wasn't sure if he was being faceitous or not...
> I've not been able to get a single 2.5 series kernel to compile since 2.5.8

I believe raid1 works.  raid5 definately doesn't.  I'm almost ready to
start looking at it actually... maybe tomorrow or the next day.  There
will be a fair bit of work needed to get it working, but it shouldn't
be very hard work (though that depends on how many bugs I introduce on
the way...)

NeiBrown
