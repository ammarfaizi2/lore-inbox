Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbRFXOic>; Sun, 24 Jun 2001 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264140AbRFXOiV>; Sun, 24 Jun 2001 10:38:21 -0400
Received: from nic.lth.se ([130.235.20.3]:34980 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S263906AbRFXOiI>;
	Sun, 24 Jun 2001 10:38:08 -0400
Date: Sun, 24 Jun 2001 16:38:05 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP+USB still crashes in 2.4.6-pre5
Message-ID: <20010624163805.A964@borg.pp.se>
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
> > hard crash when doing "cat whatever > /dev/dsp1" where /dev/dsp1 is
> > an external USB audio device
> 
> Does this happen on 2.4.5-ac kernel as well ?

On 2.4.5-ac9, yes. Haven't tested any others.

//jb
