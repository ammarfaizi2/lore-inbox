Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUBCJj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 04:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUBCJj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 04:39:26 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:9226 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265849AbUBCJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 04:39:24 -0500
Date: Tue, 3 Feb 2004 10:29:36 +0100
From: DervishD <raul@pleyades.net>
To: Dave Jones <davej@redhat.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE taskfile
Message-ID: <20040203092936.GB3035@DervishD>
References: <20040202120120.GC570@DervishD> <20040202202522.GA9503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040202202522.GA9503@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Dave :)

 * Dave Jones <davej@redhat.com> dixit:
>  > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
>  > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
>  > <30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)
> 51/04 is the drive saying "I don't understand what you asked me to do".

    OK. The codes are very self-explanatory XDD Thanks for the
explanation :)

> Ie, a command that was added to a later revision of the ATA standard
> than your drive conforms to.  Judging by the size of the drive,
> I'd guess it's quite old 8-)

    Not very old, but maybe from a 'difficult time' when the
manufacturer switched from one standard to another. BTW, my entire
Linux box with all my data, fills perfectly in 4GB ;)) Fortunately,
with Linux, you don't need a monster HD for doing everyday job :) Y
use a 40GB main disk drive to store a mirror for my favourite
distros.

    Again, thanks a lot for your explanation :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
