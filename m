Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTDGQWF (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbTDGQWF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:22:05 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:32208 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S263553AbTDGQWC (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:22:02 -0400
Date: Mon, 7 Apr 2003 18:33:35 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 features/options
In-Reply-To: <20030407102457.V1422@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.51.0304071832410.18350@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0304071323240.15910@dns.toxicfilms.tv>
 <20030407102457.V1422@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Possibly you have files larger than 2GB and the "largefile" feature is
> set?  If you get the CVS version of ext2resize it will fix this.
I have had dir_index on.

After removing the bit, resizing and restoring the bit, everything seems
fine.

Regards,
Maciej
