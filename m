Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293022AbSCJMoq>; Sun, 10 Mar 2002 07:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293024AbSCJMog>; Sun, 10 Mar 2002 07:44:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293022AbSCJMoZ>; Sun, 10 Mar 2002 07:44:25 -0500
Subject: Re: [PATCH] RPM build target fixes
To: alexh@ihatent.com (Alexander Hoogerhuis)
Date: Sun, 10 Mar 2002 12:59:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <m3sn784vmm.fsf@lapper.ihatent.com> from "Alexander Hoogerhuis" at Mar 10, 2002 10:31:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16k2v8-0006QY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats exactly the opposite of what is expected
> 
> How so? Given that it actually cleans up after itself you are not left
> with multiple .spec files in any directory? Or have I missed something?

Most source rpm packages come with a [packagename.spec] file without a 
version.
