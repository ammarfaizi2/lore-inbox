Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUBNRbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBNRbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:31:42 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:22661 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263088AbUBNRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:31:42 -0500
Date: Sat, 14 Feb 2004 17:28:39 +0000
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out fbdev sysfs support
Message-ID: <20040214172839.GA2065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <20040214165037.GA15985@lst.de> <Pine.LNX.4.58.0402140857520.13436@home.osdl.org> <20040214170600.GA16147@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214170600.GA16147@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 06:06:00PM +0100, Christoph Hellwig wrote:

 > What I meant is that the FB maintainer should try to get the existing
 > fixes merged before adding dubious features.

Whilst on the subject, why does the fb code need sysfs support
anyway ?

		Dave
