Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUHJAvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUHJAvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUHJAvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:51:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267373AbUHJAvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:51:39 -0400
Date: Tue, 10 Aug 2004 01:51:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking scheme to block less
Message-ID: <20040810005136.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <41181909.3070702@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41181909.3070702@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 08:38:33PM -0400, John Richard Moser wrote:
> Currently, the kernel uses only spin_locks, which are similar to mutex 
> locks;

Does it, really?

> If the kernel provided a read-write locking semaphore,

or if you would care to RTFS and find that it does...
