Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbRENXZH>; Mon, 14 May 2001 19:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbRENXZB>; Mon, 14 May 2001 19:25:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48139 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262573AbRENXYF>; Mon, 14 May 2001 19:24:05 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: arjan@fenrus.demon.nl (Arjan van de Ven)
Date: Tue, 15 May 2001 00:20:22 +0100 (BST)
Cc: hpa@transmeta.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <m14zRbL-000OdxC@amadeus.home.nl> from "Arjan van de Ven" at May 15, 2001 12:18:07 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zRdW-0001gY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it to a device number at /sbin/lilo time.  An idiotic practice on the
> > part of LILO, in my opinion, that ought to have been fixed a long time
> > ago.
> 
> That's why you want mount-root-by-partition-label, not by device

Which in itself adds the 'and how does the label tell me what modules to load'
question..

For 2.5 with a clean ramfs root / initrd / uuid scan setup I would agree
entirely that uuid root is a good thing.

Alan

