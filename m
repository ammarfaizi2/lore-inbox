Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNNcZ>; Wed, 14 Feb 2001 08:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBNNcP>; Wed, 14 Feb 2001 08:32:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21519 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129055AbRBNNcI>; Wed, 14 Feb 2001 08:32:08 -0500
Subject: Re: Stale super_blocks in 2.2
To: pauld@egenera.com (Phil Auld)
Date: Wed, 14 Feb 2001 13:32:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A8A87A7.4A3CE58D@egenera.com> from "Phil Auld" at Feb 14, 2001 08:27:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T22y-0004wP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can make the changes needed. I was really curious if you, or anyone else,
> thought there might be page caching issues involved with invalidating on the way
> down.

2.4 already addresses this. With 2.2 or 2.4 you can force buffer flushes from
userspace too


