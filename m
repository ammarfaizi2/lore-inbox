Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULAIfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULAIfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbULAIfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:35:50 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18919 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261337AbULAIfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:35:43 -0500
In-Reply-To: <20041130150131.2f955be9.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Subject: Re: s390 patches for -bk.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF136F10EC.36822FC6-ONC1256F5D.002EE44F-C1256F5D.002F3E21@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Wed, 1 Dec 2004 09:35:58 +0100
X-MIMETrack: S/MIME Sign by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 12/01/2004 09:36:00 AM,
	Serialize by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 12/01/2004 09:36:00 AM,
	Serialize complete at 12/01/2004 09:36:00 AM,
	S/MIME Sign failed at 12/01/2004 09:36:01 AM: The cryptographic key was not
 found,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 01/12/2004 09:36:00,
	Serialize complete at 01/12/2004 09:36:00
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > another update for s390. This is the last patch-set from me
> > for this year. I asked Heiko Carstens
> > (heiko.carstens@de.ibm.com) to keep an eye on Bitkeeper for
> > the next few weeks. If anything breaks he'll post patches to
> > keep s390 working.
> > 
> > The patches:
> > 1) s390 core fixes
> > 2) common i/o layer bug fixes
> > 3) dcss segment interface changes
> > 4) dasd driver fixes
> > 5) z/VM monitor stream change
> 
> Do you think these should be in 2.6.10?

Yes, would be good to have them in 2.6.10.

Thanks,
Heiko

