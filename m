Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbREUJVU>; Mon, 21 May 2001 05:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbREUJVK>; Mon, 21 May 2001 05:21:10 -0400
Received: from pD951F505.dip.t-dialin.net ([217.81.245.5]:13828 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S262414AbREUJU6>; Mon, 21 May 2001 05:20:58 -0400
Date: Mon, 21 May 2001 11:20:54 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernelorg, becker@scyld.com, jgarzik@mandrakesoft.com
Subject: also in 2.4: RTL8139 difficulties in 2.2, not in 2.4
Message-ID: <20010521112054.C1543@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernelorg, becker@scyld.com, jgarzik@mandrakesoft.com
In-Reply-To: <20010519140413.B1795@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519140413.B1795@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sat, May 19, 2001 at 14:04:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, I wrote:

> I'm having difficulties with a RTL8139 with Linux 2.2.19 (both drivers),
> but not with Linux 2.4.4's 8139too driver. The card is an Allied Telesyn
> AT-2500TX, the chip is reported as 8139C/rev. 0x10. The card shares its
> IRQ 9 with an nVidia Riva TNT 128 [NV04], rev. 4.

These diffculties also occasionally hit 2.4.4, so there must be some
different aspect causing these troubles.
