Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293640AbSCFQOY>; Wed, 6 Mar 2002 11:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293648AbSCFQOO>; Wed, 6 Mar 2002 11:14:14 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:17910 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S293640AbSCFQOB>; Wed, 6 Mar 2002 11:14:01 -0500
Message-ID: <3C864048.27DF51E4@redhat.com>
Date: Wed, 06 Mar 2002 16:14:00 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Bernat <bernat@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops
In-Reply-To: <m3pu2hn1z2.fsf@neo.loria>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Bernat wrote:
> 
> Hi !
> 
> I encounter problems with xmms segfaulting on two different
> kernels. The first one is 2.4.18-xfs-preempt-lockbreak-bttv. I use
> alsa drivers (0.90.0b12) for my SB PCI 128 card. The second one is
> 2.4.19-pre2-ac2 with shawn patch (xfs + rmap 12g) and preempt patch.
> 

might be worth testing without preempt to rule that out...
