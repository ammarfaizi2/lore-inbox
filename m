Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbRETTv2>; Sun, 20 May 2001 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbRETTvS>; Sun, 20 May 2001 15:51:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21770 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262060AbRETTvC>; Sun, 20 May 2001 15:51:02 -0400
Subject: Re: Getting FS access events
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 20 May 2001 20:47:20 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010520163041.A6260@metastasis.f00f.org> from "Chris Wedgwood" at May 20, 2001 04:30:41 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151ZAe-0002nL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm confused. I've always wondered that before you suspend the state
> of a machine to disk, why we just don't throw away unnecessary data
> like anything not actively referenced.

swsusp does exactly that.
