Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTE3UBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTE3UBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:01:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11422 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263981AbTE3UBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:01:17 -0400
Date: Fri, 30 May 2003 22:14:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530201429.GA3308@wohnheim.fh-wedel.de>
References: <1054324633.3754.119.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1054324633.3754.119.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 13:57:13 -0600, Steven Cole wrote:
> 
> Maybe the following should be unnecessary after all these years since
> the ANSI C standard was introduced, but several files associated with
> zlib were using the old-style function declaration.
> 
> So, here is a proposed addition to CodingStyle, just to make it clear.

In the case of the zlib, just leave it as it is.  The less changes we
make, to easier it is to merge upstream changes into the kernel.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
