Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWECPuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWECPuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWECPuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:50:52 -0400
Received: from 213-140-2-76.ip.fastwebnet.it ([213.140.2.76]:46740 "EHLO
	aa009msg.fastweb.it") by vger.kernel.org with ESMTP id S965228AbWECPuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:50:51 -0400
Date: Wed, 3 May 2006 17:50:17 +0200
From: Andrea Gelmini <andrea.gelmini@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16/MD/DM-crypt/fs corruption
Message-ID: <20060503155017.GB14534@gelma.net>
References: <20060503091653.GA5940@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503091653.GA5940@gelma.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mer, mag 03, 2006 at 11:16:53 +0200, Andrea Gelmini wrote:
> Hi all,
> 	to make short a long story:
> 	a) five pata disks Maxtor 500GB each one;
> 	b) one big software raid 5 (/dev/md1);[1]
> 	c) dmcrypt-ing /dev/md1;[2]
> 	d) after 500GB copied I've got fs corruption;[3]

it seems it's not only my problem.[1]
it would be good to put an advisory about it in menuconfig. I had spent an
incredible amount of hours trying to find hardware failure, and weeks to
re-test/reproduce the problem every time.
here[2] you can find a much more details.

thanks a lot for your time,
gelma

------
[1] http://episteme.arstechnica.com/groupee/forums/a/tpc/f/96509133/m/282007248731
[2] http://marc.theaimsgroup.com/?l=linux-raid&m=114579714925936&w=2
