Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUFNTfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUFNTfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUFNTfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:35:14 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:52459 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263804AbUFNTfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:35:11 -0400
Date: Mon, 14 Jun 2004 20:34:15 +0100
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: Can we please keep correct date when doing bk checkins?
Message-ID: <20040614193415.GA28002@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>
References: <20040614184523.93825.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614184523.93825.qmail@web81301.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 11:45:23AM -0700, Dmitry Torokhov wrote:

 > I noticed that while the sysfs_rename_dir-cleanup changeset was checked
 > in on May 14, 2004 dathes on the touched files read 2004/10/06 which is
 > obviously incorrect.

What makes you think this is incorrect ?
It's possible whoever checked in that change did it in their repo
on May 14th, and then Linus pulled the change into his tree on the
10th June, which would alter the timestamp.

		Dave

