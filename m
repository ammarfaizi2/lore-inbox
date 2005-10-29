Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVJ2U5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVJ2U5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVJ2U5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:57:44 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:58524 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932193AbVJ2U5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:57:43 -0400
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Move platform device to separate header
X-Message-Flag: Warning: May contain useful information
References: <20051029205207.GG14039@flint.arm.linux.org.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 29 Oct 2005 13:57:38 -0700
In-Reply-To: <20051029205207.GG14039@flint.arm.linux.org.uk> (Russell King's
 message of "Sat, 29 Oct 2005 21:52:07 +0100")
Message-ID: <52oe58nirh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Oct 2005 20:57:39.0257 (UTC) FILETIME=[65B21A90:01C5DCCB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Russell> Here's a patch which moves the platform device out of
    Russell> device.h and into linux/platform_device.h.  This patch is
    Russell> far too large for lkml so can be downloaded from:

It looks like you forgot to diff <linux/platform_device.h>.  It
doesn't appear in your diffstat and as far as I can tell, it's not in
the actual diff either.

 - R.
