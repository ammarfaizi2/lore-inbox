Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTEWNhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 09:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEWNht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 09:37:49 -0400
Received: from mout0.freenet.de ([194.97.50.131]:35493 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264078AbTEWNdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 09:33:42 -0400
From: Christian Klose <christian.klose@freenet.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Fri, 23 May 2003 15:46:43 +0200
User-Agent: KMail/1.5.1
References: <200305231405.54599.christian.klose@freenet.de>
In-Reply-To: <200305231405.54599.christian.klose@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305231546.27463.christian.klose@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 May 2003 15:00, Christian Klose wrote:

Hello all again :-)

> I have a problem since Linux Kernel 2.4.19. Copying huge amount of data
> gives me pauses where pauses are disk io pauses, keyboard does not accept
> input and mouse won't move. This depends, sometimes those pauses are 1 to 2
> seconds, sometimes even more up to 15 seconds where I can not do anything
> with my linux but waiting :-(
I forgot to mention that this is filesystem independant. ext2, ext3, reiserfs; 
always same problem.

bye, Chris
