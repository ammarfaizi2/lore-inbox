Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287549AbRLaPzH>; Mon, 31 Dec 2001 10:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287551AbRLaPy5>; Mon, 31 Dec 2001 10:54:57 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:23047 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287549AbRLaPyl>; Mon, 31 Dec 2001 10:54:41 -0500
Subject: Re: ATA RAID-0 FYI-Did the Impossible.
From: Miles Lane <miles@megapathdsl.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10112310558030.4280-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10112310558030.4280-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.29.08.57 (Preview Release)
Date: 31 Dec 2001 07:55:28 -0800
Message-Id: <1009814128.1407.59.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-31 at 06:05, Andre Hedrick wrote:

<snip>

> If you want your system to have this kind of performance, that raise hell
> to get the patches adopted into the main kernel.

Have you asked Linus and Marcelo why your patches aren't being 
accepted?  Linus and Hans Reiser eventually sorted out what 
was required for getting reiserfs into the kernel, though it 
took some negotiation and compromise of the part of the reiserfs
folks.  I imagine you can do the same.

It's a no-brainer that we all want fast disk I/O.

	Miles

