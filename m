Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWJAGoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWJAGoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 02:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWJAGoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 02:44:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:62915 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752037AbWJAGoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 02:44:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index:message-id;
        b=A4EWpSHSQp84MYz64hV8ZDcJzPRjn8pxFrSMOOZo8h1a5MOC5Hg1YuCSCcDrumB7v9lWOG9adcxgG2I1E/5lRY9msJNpLpgdpp7EErgvk1+lnn1W60fWSIw3hpUPDFWHoBILXFJh2wZgF6bs0DDvoO1SjvZcdPJk53sn2wvppJs=
From: "Chris Lee" <labmonkey42@gmail.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       <linux-scsi@vger.kernel.org>, <Neela.Kolli@engenio.com>
Subject: RE: Problem with legacy megaraid
Date: Sun, 1 Oct 2006 01:44:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20060930230259.497b7bc9.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Thread-Index: AcblH0H1o/3Jk+L5TPSSVpEakJV4UwABL70g
Message-ID: <451f63b0.0b6e62c3.1073.0ffa@mx.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > > Distro: Gentoo Linux
> > > > Kernel: 2.6.17-gentoo-r7
> > > > 
> > > > Hardware:
> > > > Motherboard: Tyan Thunder i7501 Pro (S2721-533)
> > > > CPUs: Dual 2.8Ghz P4 HT Xeons
> > > > RAM: 4GB registered (3/1 split, flat model)
> > > > RAID: Dell PERC2/DC (AMI Megaraid 467)
> > > > SCSI: Adaptec AHA-2940U2/U2W PCI
> > > > NICs: onboard e100 and dual onboard e1000
> > > > 
> 
> Did it work correctly under any earlier kernel version?  If 
> so, which?

I've recently built the system and the problem was present with both
2.6.16-gentoo-r4 and now 2.6.17-gentoo-r7.  I've not used any earlier kernel
versions in this system.

Thanks,
Chris  

