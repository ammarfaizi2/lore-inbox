Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbULDCtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbULDCtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 21:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbULDCtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 21:49:05 -0500
Received: from [61.149.23.123] ([61.149.23.123]:56813 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262523AbULDCtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 21:49:02 -0500
Date: Fri, 3 Dec 2004 18:39:25 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412040239.iB42dPi12085@adam.yggdrasil.com>
To: greg@kroah.com
Subject: Re: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004 10:56:31 -0800, Greg KH wrote:
>Thanks, I've deleted the BUG_ON() and will be sending the patch on to
>Linus in a bit.

	Great, thanks.

>(oh, care to add a "Signed-off-by:" line to your patches?)

	When we first started using Signed-off-by: lines, I did,
and then somebody commented on it to me in some way that gave me
the impression that the practice was only for people who "approve"
patches, but I'm happy to resume adding Signed-off-by: lines to all
of my patches that are proposed for integration in the future.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
