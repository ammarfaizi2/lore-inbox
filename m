Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbRBXUzo>; Sat, 24 Feb 2001 15:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129600AbRBXUzY>; Sat, 24 Feb 2001 15:55:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129599AbRBXUzN>; Sat, 24 Feb 2001 15:55:13 -0500
Subject: Re: Loop device hang
To: mbratche@rochester.rr.com (Mark Bratcher)
Date: Sat, 24 Feb 2001 20:56:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A97F1B1.109432F8@rochester.rr.com> from "Mark Bratcher" at Feb 24, 2001 12:38:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WlkO-0000TK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has the loop device hang problem that was in kernel 2.4.0 been fixed in
> 2.4.1 or 2.4.2?

2.4.2 + loop-6 patch or 2.4.2-ac
