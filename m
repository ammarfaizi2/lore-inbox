Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUJIMyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUJIMyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 08:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJIMyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 08:54:20 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:28360 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S266793AbUJIMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 08:54:20 -0400
Date: Sat, 9 Oct 2004 21:08:00 +0930
From: John Hedditch <jhedditc@physics.adelaide.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041009210800.A19862@bragg.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By disabling compilation of usb, s2io and scsi I can get this to build and link, but it hangs immediately on getting
to init.

Cheers,
John
