Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSANXeE>; Mon, 14 Jan 2002 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289292AbSANXdy>; Mon, 14 Jan 2002 18:33:54 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:31128 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289289AbSANXdu>; Mon, 14 Jan 2002 18:33:50 -0500
Date: Mon, 14 Jan 2002 18:33:46 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201142333.g0ENXks24669@devserv.devel.redhat.com>
To: david.lang@digitalinsight.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <mailman.1011034621.1626.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1011034621.1626.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. simplicity in building kernels for other machines. with a monolithic
> kernel you have one file to move (and a bootloader to run) with modules
> you have to move quite a few more files.

It is easy to automate. Simply build RPMs and install them.

Die-hard RPM haters may use some ad-hoc tools as well, see:
http://people.redhat.com/zaitcev/linux/linux-collect

-- Pete
