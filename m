Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBLPeX>; Wed, 12 Feb 2003 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBLPdz>; Wed, 12 Feb 2003 10:33:55 -0500
Received: from [213.86.99.237] ([213.86.99.237]:65532 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267254AbTBLPdT>; Wed, 12 Feb 2003 10:33:19 -0500
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
	i8042?
From: David Woodhouse <dwmw2@infradead.org>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
References: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045064557.19882.46.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Feb 2003 15:42:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 15:36, Shawn Starr wrote:

> Interesting, why are we using two interrupts for the i8042 (keyboard).

Because the mouse is connected to the i8042 too.

-- 
dwmw2
