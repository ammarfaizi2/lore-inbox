Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279042AbRJVWuy>; Mon, 22 Oct 2001 18:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279034AbRJVWuI>; Mon, 22 Oct 2001 18:50:08 -0400
Received: from domino1.resilience.com ([209.245.157.33]:35022 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S279029AbRJVWth>; Mon, 22 Oct 2001 18:49:37 -0400
Message-ID: <3BD4B05C.8C18BAA2@resilience.com>
Date: Mon, 22 Oct 2001 16:48:44 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: drevil@warpcore.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be> <E15vlcJ-0003E5-00@the-village.bc.nu> <20011022172742.B445@virtucon.warpcore.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drevil@warpcore.org wrote:
> 
> On Mon, Oct 22, 2001 at 09:24:11PM +0100, Alan Cox wrote:
> > Only Nvidia can help you
> 
> With a problem caused by someone else and not them? Interesting viewpoint.

Not really.  If a change is made to the kernel, people can't roll any
relevant changes into nvidia's driver because only nvidia has the
source.  For example, if the PCI driver interface was changed, then that
too would likely break nvidia's driver.  However, it wouldn't break the
open-source drivers because the changes would be merged into them.

As soon as nvidia releases an open-source driver, then you can blame the
kernel developers for breaking the driver.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
