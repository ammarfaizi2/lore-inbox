Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUBWCT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUBWCT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:19:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:10507 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261781AbUBWCT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:19:56 -0500
Date: Mon, 23 Feb 2004 02:19:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-ID: <20040223021948.A4131@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>; from akpm@osdl.org on Sun, Feb 22, 2004 at 05:22:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 05:22:00PM -0800, Andrew Morton wrote:
> - Big s390 update.  This includes rework against net devices, block devices
>   and sysfs interfaces.   Please Cc Martin Schwidefsky on review comments ;)

Adding the HBA API ioctl crap to zfcp is not acceptable, the qlogic ioctls
already were shot down for the same reason.

Btw, please send scsi patch to linux-scsi please.

