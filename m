Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWAZUkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWAZUkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAZUkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:40:16 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:62917 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932242AbWAZUkP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:40:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B1FvLDqlgpN0qmxJfwFwaNpkxVndA33lkPwuIuVucIEeMzMzdASaqZyXcdDtABNlVWTtZ5ZLdR3DTI1aEjs2g8+FcJQgLJ/K17ig5ICfPU8kzj+S0pFQiapc3ZbdXJUeM0miuWa4na0hH8uH3iozeriPzhchWbb1DYxTlu7rqTQ=
Message-ID: <de63970c0601261240i1770324ek@mail.gmail.com>
Date: Thu, 26 Jan 2006 20:40:14 +0000
From: Simon Morgan <sjmorgan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Asus P5A Reboots
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble running the installation for Arch 0.7.1 on an Asus P5A
motherboard. The installation uses the 2.6.15 kernel and the problem is
that during, or immediately after, the initrd decompression stage the
machine reboots.

I've tried running an alternative installation kernel without SCSI support
as well as a number of kernel parameters (noacpi, noapm, acpi=off), none of
which helped.

The hardware is good, it is currently running another operating system
without issue and I gave the memory a thorough check with memtest86+ not
too long ago.

I have no idea where to even begin to find the source of this problem
but if anybody could offer some ideas or suggestions I would appreciate it.

Thanks.

Simon

P.S. Please CC me on any replies as I'm not subscribed to the list.
