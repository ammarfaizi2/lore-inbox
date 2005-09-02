Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbVIBOfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVIBOfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbVIBOfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:35:22 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:35216 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1161028AbVIBOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:35:20 -0400
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE HPA
In-Reply-To: <62b0912f05090206331d04afd3@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com> <200508300859.19701.tennert@science-computing.de> <87941b4c05083008523cddbb2a@mail.gmail.com> <1125419927.8276.32.camel@localhost.localdomain> <87941b4c050830095111bf484e@mail.gmail.com> <62b0912f0509020027212e6c42@mail.gmail.com> <1125666332.30867.10.camel@localhost.localdomain> <1125666332.30867.10.camel@localhost.localdomain> <62b0912f05090206331d04afd3@mail.gmail.com>
Date: Fri, 2 Sep 2005 15:35:18 +0100
Message-Id: <E1EBCdS-00064p-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich <molle.bestefich@gmail.com> wrote:

> If HPA were exposed as /dev/.../hpa then it wouldn't be possible to
> create such a filesystem. I'm guessing it's not possible with Windows
> either, or with any BIOS-based OS.

Such filesystems already exist. Changing this behaviour now would break
existing setups.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
