Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTAaPzG>; Fri, 31 Jan 2003 10:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTAaPzG>; Fri, 31 Jan 2003 10:55:06 -0500
Received: from [66.70.28.20] ([66.70.28.20]:3590 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261527AbTAaPzF>; Fri, 31 Jan 2003 10:55:05 -0500
Date: Fri, 31 Jan 2003 16:58:18 +0100
From: DervishD <raul@pleyades.net>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre4-ac1
Message-ID: <20030131155818.GH42@DervishD>
References: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Alan :)

> Linux 2.4.21pre4-ac1
> o	Restore the mmap corner case fix		(Raul)

    I'm afraid I just prepare and sent the patch, Dave Miller
corrected my original patch to make it work in 'big TASK_SIZE'
architectures (namely sparc64).

    BTW, thanks for applying, Alan :)

    Raúl
