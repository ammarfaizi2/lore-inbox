Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317717AbSGVRgn>; Mon, 22 Jul 2002 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317718AbSGVRgn>; Mon, 22 Jul 2002 13:36:43 -0400
Received: from real.realitydiluted.com ([208.242.241.164]:17368 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id <S317717AbSGVRgm>; Mon, 22 Jul 2002 13:36:42 -0400
Message-ID: <3D3C435F.7080603@realitydiluted.com>
Date: Mon, 22 Jul 2002 12:39:43 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Karol Olechowskii <karol_olechowski@acn.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon XP 1800+ segemntation fault
References: <20020722133259.A1226@acc69-67.acn.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Olechowskii wrote:
> 
> Few days ago I've bought new processor Athlon XP 1800+ to my computer
> (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
> 900 processor and everything had been working well till I change to the new one.
> Now for every few minutes I've got segmetation fault or immediate system reboot.
> Could anyone tell me what's goin' on?
> 
I too have the MSI K7D Master. As Alan mentioned, the 2.4.19-rc2-ac2
patch works fine. My machine has been rock solid and I'm running dual
XP 2000+. However, I'm running Radeon 8500 (I refused to give my money
to a company that doesn't release it's drivers). Bad memory is a
possibility, so run 'memtest' and see what happens as mentioned by
others. Also, I suggest you upgrade to v1.3 of the MSI 6501 BIOS which
is always a good idea. As far as your X crashes, you might try building
the latest X out of CVS and see if that helps at all, but it looks
like memory problems. Spend the money and buy good name brand like
Micron/Crucial has been good for me. Just my $0.02.

-Steve

