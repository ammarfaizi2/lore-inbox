Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRBYXJ0>; Sun, 25 Feb 2001 18:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129910AbRBYXJQ>; Sun, 25 Feb 2001 18:09:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129903AbRBYXJG>; Sun, 25 Feb 2001 18:09:06 -0500
Subject: Re: Linux 2.4.2-ac4
To: david@blue-labs.org (David)
Date: Sun, 25 Feb 2001 23:12:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A998C19.7010403@blue-labs.org> from "David" at Feb 25, 2001 02:50:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XAKn-0004cg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this have any fixings for the RSS and CPU mis-allocations?  I put 
> 2.4.2 ac3 on my notebook last night and Enlightenment is taking 9805% of 
> the cpu and about 4 terabytes is resident.
> That is the only process doing that.

Not yet. Im waiting for the VM folks to fix it.
