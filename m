Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266573AbRGLU6E>; Thu, 12 Jul 2001 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbRGLU5y>; Thu, 12 Jul 2001 16:57:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266573AbRGLU5o>; Thu, 12 Jul 2001 16:57:44 -0400
Subject: Re: NFS Client patch
To: cw@f00f.org (Chris Wedgwood)
Date: Thu, 12 Jul 2001 21:57:55 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), soules@happyplace.pdl.cmu.edu (Craig Soules),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010711060418.A32421@weta.f00f.org> from "Chris Wedgwood" at Jul 11, 2001 06:04:18 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15KnX2-0006qk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     An ordered sequence does not include cycles.
> 
> *Who* says NFS has to be a *unix* like filesystem?

NFS is most emphatically not a posix compliant FS, at the best of times.
