Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281556AbRKUJTd>; Wed, 21 Nov 2001 04:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281543AbRKUJTM>; Wed, 21 Nov 2001 04:19:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281441AbRKUJTH>; Wed, 21 Nov 2001 04:19:07 -0500
Subject: Re: A return to PCI ordering problems...
To: jas88@cam.ac.uk (James A Sutherland)
Date: Wed, 21 Nov 2001 09:20:21 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), amon@vnl.com (Dale Amon),
        linux-kernel@vger.kernel.org
In-Reply-To: <E166TCM-0004VH-00@lilac.csi.cam.ac.uk> from "James A Sutherland" at Nov 21, 2001 08:57:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E166TYL-0004Sv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you really care about the names, there's an ioctl you can use to change
> > them. You can call them 'fred' and 'sheila' if you so desire.
> 
> So you can you swap them, so eth1 becomes eth0? If so, that should solve his 
> problem...

You can do yes
