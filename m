Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292017AbSBTQzZ>; Wed, 20 Feb 2002 11:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292015AbSBTQzS>; Wed, 20 Feb 2002 11:55:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292017AbSBTQzC>; Wed, 20 Feb 2002 11:55:02 -0500
Subject: Re: sis_malloc / sis_free
To: jsimmons@transvirtual.com (James Simmons)
Date: Wed, 20 Feb 2002 17:08:37 +0000 (GMT)
Cc: sartre@linuxbr.com (Jean Paul Sartre),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10202200841290.5890-100000@www.transvirtual.com> from "James Simmons" at Feb 20, 2002 08:43:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16daEP-000463-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> will see this happen more and more in the future. Eventually I like to
> merge both interfaces into one universal interface, but before I do that
> the whole fbdev layer needs to be cleaned up which I'm doing now. 

For 2.5 now is the time to move DRM if you want to.  I agree it makes sense
to shove it in video/drm
