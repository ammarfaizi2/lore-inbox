Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269001AbRHGQyE>; Tue, 7 Aug 2001 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHGQxy>; Tue, 7 Aug 2001 12:53:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269001AbRHGQxm>; Tue, 7 Aug 2001 12:53:42 -0400
Subject: Re: Encrypted Swap
To: cw@f00f.org (Chris Wedgwood)
Date: Tue, 7 Aug 2001 17:54:56 +0100 (BST)
Cc: helgehaf@idb.hist.no (Helge Hafting),
        crutcher@datastacks.com (Crutcher Dunnavant),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010808035647.D26290@weta.f00f.org> from "Chris Wedgwood" at Aug 08, 2001 03:56:47 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UA88-0003Eg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 07, 2001 at 11:23:04AM +0200, Helge Hafting wrote:
>     A relatively cheap way might be a custom pci
>     card with a self-destruct RAM bank for
>     storing the decryption keys.  Opening the
>     safe cause the card to zero the RAM.
> 
> Custom PCI card?  You can already buy such beasts (the tamper on them
> presently has no pins on it, just vacant pads, but you could attach it
> to a case if you wanted).

Since several people have asked me directly about the IBM thing

	http://www-124.ibm.com/developerworks/oss/4758/index.html

And no I've no idea how much they cost, but since it says 'and talk to a
4758 PCI specialist' I suspect its not $25 a shot 8)
