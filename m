Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269412AbUI3S32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbUI3S32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269402AbUI3S31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:29:27 -0400
Received: from gw.goop.org ([64.81.55.164]:25041 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S269398AbUI3SZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:25:22 -0400
Subject: Re: Unsupported speedstep
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Marcus Sundberg <marcus@ingate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <415ACA3C.908@ingate.com>
References: <415ACA3C.908@ingate.com>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 11:25:16 -0700
Message-Id: <1096568717.3995.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 16:44 +0200, Marcus Sundberg wrote:
> Hi,
> 
> my 1.1 GHz dothan apparently isn't supported yet. I've seen patches for
> stepping 6 1.5GHz and up, but none for 1.1 GHz, so here's the /proc/cpuinfo:

This should be fine in 2.6.9-rc2, using the ACPI tables option.

	J

