Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133109AbRDRMnE>; Wed, 18 Apr 2001 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRDRMmy>; Wed, 18 Apr 2001 08:42:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49669 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133109AbRDRMml>; Wed, 18 Apr 2001 08:42:41 -0400
Subject: Re: Kernel 2.5 Workshop RealVideo streams -- next time, please get better  audio.
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 18 Apr 2001 13:44:32 +0100 (BST)
Cc: miles@megapathdsl.net (Miles Lane), linux-kernel@vger.kernel.org
In-Reply-To: <m1lmoys7wt.fsf@frodo.biederman.org> from "Eric W. Biederman" at Apr 18, 2001 06:34:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14prJy-0004eW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So my question is, what would it take to get some automatic software
> volume correction going.  This looks like it would be the easiest fix
> of all.

Unfortunately its encoded in a proprietary format otherwise it would have
been perhaps half an hours work to write an AGC filter for the data.

Alan

