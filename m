Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271679AbRICLGP>; Mon, 3 Sep 2001 07:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRICLFz>; Mon, 3 Sep 2001 07:05:55 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:52242 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271679AbRICLFo>; Mon, 3 Sep 2001 07:05:44 -0400
Message-ID: <3B935FF8.935244CE@namesys.com>
Date: Mon, 03 Sep 2001 14:48:24 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        willy@debian.org, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc 
 architecture
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <E15dghq-0000bZ-00@the-village.bc.nu.suse.lists.linux.kernel> <oup66b0zq9j.fsf@pigdrop.muc.suse.de> <20010903.011530.62340995.davem@redhat.com> <20010903104105.A3398@gruyere.muc.suse.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the sum of this is that Jeff's patches work on the platforms he wrote
them for, and we need one more fix for PA-RISC.

So, we can reasonably send Jeff's patches to Linus, and test and then put the
PA-RISC patch into the AC tree, any disagreement?

Hans
