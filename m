Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136778AbREIRfr>; Wed, 9 May 2001 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136776AbREIRfh>; Wed, 9 May 2001 13:35:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34059 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136775AbREIRf1>; Wed, 9 May 2001 13:35:27 -0400
Subject: Re: Linux 2.4 Scalability, Samba, and Netbench
To: atheurer@austin.ibm.com (Andrew M. Theurer)
Date: Wed, 9 May 2001 18:39:01 +0100 (BST)
Cc: mkravetz@sequent.com (Mike Kravetz), lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        samba-technical@samba.org (samba-technical)
In-Reply-To: <3AF97EBB.9F0ABE9A@austin.ibm.com> from "Andrew M. Theurer" at May 09, 2001 12:30:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xXvT-0002ri-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> significant problems with lockmeter.  csum_partial_copy_generic was the
> highest % in profile, at 4.34%.  I'll see if we can get some space on

Are you using Antons optimisations to samba to use sendfile ?

Alan

