Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVLMUlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVLMUlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVLMUlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:41:37 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:1172 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751256AbVLMUlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:41:36 -0500
Date: Tue, 13 Dec 2005 15:41:26 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2/2] ide/sis5513: Add support for 965 chipset
In-reply-to: <58cb370e0512131157y1176bbdbk5914c67c51a9a0f0@mail.gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Message-id: <1134506487.12502.20.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.2
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1134498192250-git-send-email-bcollins@ubuntu.com>
 <1134498254295-git-send-email-bcollins@ubuntu.com>
 <58cb370e0512131038q49271226xfe932476bb05d2d0@mail.gmail.com>
 <1134502230.12502.17.camel@localhost.localdomain>
 <58cb370e0512131157y1176bbdbk5914c67c51a9a0f0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 20:57 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/13/05, Ben Collins <ben.collins@ubuntu.com> wrote:
> > On Tue, 2005-12-13 at 19:38 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Hi,
> > >
> > > SiS965 support has been merged recently (different patch because
> > > sis5513_pci_tbl[] chunk of this patch causes problems on the real
> > > SiS180 controller).
> > >
> > > Please ask the user to test vanilla 2.6.15-rc5.
> >
> > This patch was against 2.6.15-rc5.
> 
> The original bug was filled against 2.6.12-9-amd64-k8 and then
> reported to work with this patch with 2.6.14-something (probably,
> because the exact kernel version is not mentioned in the bugzilla).
> 
> Were you able to reproduce the problem with 2.6.15-rc5?

No, but the useful bits were nowhere to be found, so I figured that it
still applied.

> BTW please use linux-ide@vger.kernel.org for ATA stuff

Sure thing.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

