Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRFYQdf>; Mon, 25 Jun 2001 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRFYQdZ>; Mon, 25 Jun 2001 12:33:25 -0400
Received: from nic.lth.se ([130.235.20.3]:21174 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S264875AbRFYQdQ>;
	Mon, 25 Jun 2001 12:33:16 -0400
Date: Mon, 25 Jun 2001 18:33:06 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP+USB still crashes in 2.4.6-pre5
Message-ID: <20010625183306.A453@borg.pp.se>
In-Reply-To: <E15E9NV-0008EE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15E9NV-0008EE-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 01:52:37PM +0100, Alan Cox wrote:
> > Just wanted people to know that the same problem I reported about 2.4.4 a
> > while back is still present in 2.4.6-pre6 (hard crash when doing "cat
> > whatever > /dev/dsp1" where /dev/dsp1 is an external USB audio device, where
> > "hard crash" means a freeze followed by "wait on irq" message as reported
> > earlier).
> 
> Does this happen on 2.4.5-ac kernel as well ?

The same problem is present in -ac18.

//jb
