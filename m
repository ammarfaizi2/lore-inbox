Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278479AbRJVKKD>; Mon, 22 Oct 2001 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278477AbRJVKJx>; Mon, 22 Oct 2001 06:09:53 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:54020 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S275278AbRJVKJh>;
	Mon, 22 Oct 2001 06:09:37 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100303b7f9a0968eab@[192.168.239.101]>
In-Reply-To: <20011022094224.99093.qmail@web14703.mail.yahoo.com>
In-Reply-To: <20011022094224.99093.qmail@web14703.mail.yahoo.com>
Date: Mon, 22 Oct 2001 11:09:24 +0100
To: Peter Moscatt <pmoscatt@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Can't See CDR-W After Compile ??
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:42 am -0700 22/10/2001, Peter Moscatt wrote:
>I have compiled my first kernel (2.4.10) and all has
>gone well except I now can't access the CDR-W.
>
>I have included SCSI Support and included what I think
>may need to be loaded as well.
>
>I see it as an IDE drive but has no SCSI-Emulation.

You probably need ide-scsi.  That's either under "SCSI" or "IDE", 
don't remember which.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
