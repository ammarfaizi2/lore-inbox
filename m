Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVBVUy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVBVUy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBVUy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:54:26 -0500
Received: from rain.plan9.de ([193.108.181.162]:2720 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S261241AbVBVUyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:54:23 -0500
Date: Tue, 22 Feb 2005 21:54:19 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Alex Adriaanse <alex.adriaanse@gmail.com>
Cc: Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
Message-ID: <20050222205419.GA12797@schmorp.de>
Mail-Followup-To: Alex Adriaanse <alex.adriaanse@gmail.com>,
	Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <93ca3067050220212518d94666@mail.gmail.com> <4219C811.5070906@domdv.de> <20050222190149.GB9590@schmorp.de> <421B8A69.8000903@domdv.de> <20050222194900.GB10968@schmorp.de> <93ca306705022212461f9e0d81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ca306705022212461f9e0d81@mail.gmail.com>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 02:46:44PM -0600, Alex Adriaanse <alex.adriaanse@gmail.com> wrote:
> On Tue, 22 Feb 2005 20:49:00 +0100, Marc A. Lehmann <pcg@goof.com> wrote:
> > Well, I do use reiserfs->aes-loop->lvm/dm->md5/raid5, and it never failed
> > for me, except once, and the error is likely to be outside reiserfs, and
> > possibly outside lvm.
> 
> Marc, what about you, were you using dm-snapshot when you experienced
> temporary corruption?

No snapshots either.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
