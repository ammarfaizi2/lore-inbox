Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137208AbREKSlS>; Fri, 11 May 2001 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137206AbREKSlI>; Fri, 11 May 2001 14:41:08 -0400
Received: from intranet.resilience.com ([209.245.157.33]:39130 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S137204AbREKSkx>; Fri, 11 May 2001 14:40:53 -0400
Mime-Version: 1.0
Message-Id: <p05100301b721e284846f@[10.128.7.49]>
In-Reply-To: <01051119245402.00434@athlon>
In-Reply-To: <01051022310100.00484@athlon> <01051119245402.00434@athlon>
Date: Fri, 11 May 2001 11:40:40 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [2.4.4ac4] Kernel crash while unmounting CD: cause and
 solution
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:24 PM +0200 2001-05-11, Andreas Hartmann wrote:
>  > [1.] One line summary of the problem:
>>
>>  Kernel panic when trying to unmount a ide-scsi cdrom.
>
>The problem was a not properly working cd-rw-device. I cleaned the optical
>lens - and the cd-rw-device is working like at the beginning of its days.
>With the same CD's which it doesn't want to burn and which causes the crash
>before!

Not that a dirty CD lens should be able to cause a panic....
-- 
/Jonathan Lundell.
