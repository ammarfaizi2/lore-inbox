Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUDSQrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUDSQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:46:13 -0400
Received: from av7-1-sn2.hy.skanova.net ([81.228.8.108]:57534 "EHLO
	av7-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261497AbUDSQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:45:45 -0400
Cc: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <1082001287.407e0787f3c48@webmail.LaTech.edu> <200404151455.36307.kos@supportwizard.com> <1082044297.407eaf894ddda@webmail.LaTech.edu> <407F1C07.6050104@umn.edu> <407F30F5.1070305@pobox.com>
Message-ID: <opr6pp57mvesu439@mail1.telia.com>
From: Henrik Gustafsson <lkml@fnord.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Mon, 19 Apr 2004 18:45:33 +0200
In-Reply-To: <407F30F5.1070305@pobox.com>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cut]

> I _really_ like the SX4 -- it gives the programmer full control over all 
> aspects of RAID operation, while providing useful hardware acceleration 
> where it's needed.  And not getting in the way of the programmer, when 
> it's not needed.

Does this mean that the hardware-accelerated RAID5-mode will be compatible 
with soft-RAID5? So that I am able to create a RAID5-array today and get 
all the goodies from hardware-support later without having to do the 
backup - recreate-array - restore dance?

[cut]

// Henrik Gustafsson
