Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTF1F61 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 01:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTF1F60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 01:58:26 -0400
Received: from orngca-mls01.socal.rr.com ([66.75.160.16]:56798 "EHLO
	orngca-mls01.socal.rr.com") by vger.kernel.org with ESMTP
	id S264608AbTF1F60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 01:58:26 -0400
Subject: Re: Dell vs. GPL
From: Joshua Penix <jpenix@binarytribe.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306280005000.29249-100000@gibson.mw.luc.edu>
References: <Pine.LNX.4.44.0306280005000.29249-100000@gibson.mw.luc.edu>
Content-Type: text/plain
Message-Id: <1056780761.10255.10.camel@granite>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 23:12:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 22:51, Fluke wrote:
>   Dell is providing binary only derived works of the Linux kernel and the 
> modutils package at ftp://ftp.dell.com/fixes/boot-floppy-rh9.tar.gz
> 
>   The GPL appears to provide four terms under section 3 that Dell may 
> legally redistribute these works:
> 
> - In regards to GPL 3a, Dell does *NOT* provide the source code as part of 
> the tar.gz

Stop right there.  Yes they do.  Mount those images and you'll find boot
disks identical to the RedHat-provided ones, except that the vmlinuz
kernel image is different.  The difference is produced by applying the
'serverworks.patch' file that is ALSO included right along with the disk
images.

Source and binaries, all wrapped up in one nice package.  Please do your
research before accusing vendors of not following GPL.  It shines a bad
light on our community.

--Josh

