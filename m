Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUCPTDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCPTC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:02:59 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:12296 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261258AbUCPTC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:02:57 -0500
Date: Tue, 16 Mar 2004 20:00:30 +0100
From: DervishD <raul@pleyades.net>
To: Jens Axboe <axboe@suse.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3-order allocation failed with cdda2wav
Message-ID: <20040316190030.GA14166@DervishD>
References: <20040316184640.GA14088@DervishD> <20040316185609.GV2977@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040316185609.GV2977@suse.de>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jens :)

 * Jens Axboe <axboe@suse.de> dixit:
> >     Maybe a cdda2wav problem? Kernel problem?
> You can ignore the messages, but yeah I know they are annoying...

    If I can safely ignore them, the only problem is the waste of
sectors for my /var/log/messages ;))) Men, you've answered REAL fast
;))) Thanks a lot :)

> >     In addition to this problem, I have another one, this time
> > related with interfaces: if I use the SCSI generic interface with
> > cdda2wav, it runs without problems (well, except that noted above)
> > but uses a lot of CPU (up to 60%), so I tested with cooked_ioctl
> > interface, and then the CPU use drops to 4% but I got two error
> > messages about CDIOCSETCDDA not available, but the allocation problem
> > DOES NOT HAPPEN :?
> >     Any help? Thanks in advance :)
> Upgrade to 2.6.5-rc1, it'll solve all your problems in this area :-)

    Thanks for the advice :) I'm planning to switch to 2.6.x, but
first I must make a list with all software I must upgrade together
with the kernel. Moreover, I had in mind switching at 2.6.10.

    Thanks a lot for answering so fast and for the advice :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
