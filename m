Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTJCMY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTJCMY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:24:57 -0400
Received: from mail.midmaine.com ([66.252.32.202]:21653 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S263728AbTJCMY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:24:56 -0400
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD680, kernel 2.4.21, and heartache
X-Eric-Conspiracy: There Is No Conspiracy
References: <87brsybm41.fsf@loki.odinnet>
	<200310031159.h93BxfYm000758@81-2-122-30.bradfords.org.uk>
From: Erik Bourget <erik@midmaine.com>
Date: Fri, 03 Oct 2003 08:23:56 -0400
In-Reply-To: <200310031159.h93BxfYm000758@81-2-122-30.bradfords.org.uk> (John
 Bradford's message of "Fri, 3 Oct 2003 12:59:41 +0100")
Message-ID: <87lls2tspv.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

>> Some factors that are definitely NOT a problem: - Faulty run of drives.
>> This has also happened to Hitachi 80GB drives in the same configurations.
>> 
>> - Heat.  They're in a chilly room.  The cases haven't overheated.  We've had
>>   guys checking this every few hours after the first one went bonkers.
>> 
>> Possible problems -
>> - Simple software problem that somebody can fix and save the day. :)
>> - All Dell Poweredge 650 servers are broken.  :/
>
>> Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr: status=0x51 { DriveReady
>> SeekComplete Error } Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr:
>> error=0x40 { UncorrectableError }, LBAsect=37694874, high=2, low=4140442,
>> sector=35220864
>
> That is definitely an error from the drive.  If you're absolutely sure
> it's not a faulty batch of drives or a cooling issue, maybe you have
> power supply problems?  Does SMART give you any useful information?
>
> John.

Not power supply problems; two of the machines that have this problem are
located in different facilities even.  What's SMART?

Thanks, 
- Erik

