Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264829AbUD1O72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbUD1O72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUD1O72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:59:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10915 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S264829AbUD1O7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:59:25 -0400
Date: Wed, 28 Apr 2004 07:59:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 PATCH] PPC32: more Carolina IDE
Message-ID: <20040428145923.GH3731@smtp.west.cox.net>
References: <Pine.GSO.4.44.0404281042150.7699-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0404281042150.7699-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 10:43:30AM +0300, Meelis Roos wrote:

> PREP_IBM_CAROLINA_IDE_3 was added to C code but not to the headers. The
> following patch makes it compile but pease check the constant value - I
> only interpolated it :)

Yes, this is fine.  See http://lkml.org/lkml/2004/4/27/208 and akpm has
already passed this along to Linus.

-- 
Tom Rini
http://gate.crashing.org/~trini/
