Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267914AbRGRTpy>; Wed, 18 Jul 2001 15:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbRGRTpo>; Wed, 18 Jul 2001 15:45:44 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:35202 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267914AbRGRTpc>; Wed, 18 Jul 2001 15:45:32 -0400
Message-ID: <3B55E7A8.1786F70A@redhat.com>
Date: Wed, 18 Jul 2001 15:46:48 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florin Andrei <florin@sgi.com>
CC: linux-xfs@oss.sgi.com, seawolf-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: noapic strikes back
In-Reply-To: <995484908.1279.0.camel@stantz.corp.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Andrei wrote:
> 
> I have a SGI 1200 (L440GX+ motherboard, dual PIII) and i'm trying to
> install at least one version of Red Hat 7.1 on it.
> The problem is, while booting up the installer, when it comes to loading
> up the SCSI driver (AIC7xxx) the system is frozen.
> 
> I tried the following boot disks:
> - stock Red Hat 7.1
> - Doug Ledford's updates from people.redhat.com
> - SGI XFS 1.0.1
> 
> I tried to boot the installer with and without "noapic" option.

When using my boot disk, you have to use the "apic" option, not the "noapic"
option.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
