Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUIDRvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUIDRvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUIDRvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:51:38 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54168 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265098AbUIDRtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:49:22 -0400
Subject: Re: [2.4.25] "pc_keyb: controller jammed (0xFF)" on Super Micro
	P5MMA98
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1B6CEB06-FE2B-11D8-B9BD-000393ACC76E@mac.com>
References: <1B6CEB06-FE2B-11D8-B9BD-000393ACC76E@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094316425.10555.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:47:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 05:30, Kyle Moffett wrote:
> I have a Super Micro P5MMA98 motherboard that does not recognize the 
> PS/2
> keyboard controller under Debian.  It repeatedly gives errors like the 

Go into the BIOS, disable "USB legacy" support. Retest. If that fixes it
then look for a BIOS update and/or complain to your board vendor as
appropriate. If not come back here 

