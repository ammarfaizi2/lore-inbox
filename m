Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbUKAPvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUKAPvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUKAPu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:50:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40176 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262559AbUKAODC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:03:02 -0500
Subject: Re: [2.6 patch] JFS: make some symbols static
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041030072327.GI4374@stusta.de>
References: <20041030072327.GI4374@stusta.de>
Content-Type: text/plain
Message-Id: <1099317775.7474.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 01 Nov 2004 08:02:55 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 02:23, Adrian Bunk wrote:
> The patch below makes some JFS symbols that are only used inside the 
> file they are defined in static.
>
> ...

Looks sane.  I'll apply this and push it to Andrew.

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
shaggy@austin.ibm.com

