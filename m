Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWEKSgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWEKSgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEKSgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:36:45 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:11715 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750883AbWEKSgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:36:44 -0400
Date: Thu, 11 May 2006 20:35:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>, linux-kernel@vger.kernel.org
Subject: Re: fix compiler warning in ip_nat_standalone.c
Message-ID: <20060511183540.GC14232@wohnheim.fh-wedel.de>
References: <200605111729.48871.Rik.Bobbaers@cc.kuleuven.be> <20060511155537.GF1104@wohnheim.fh-wedel.de> <20060511161846.GM27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060511161846.GM27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 17:18:46 +0100, Al Viro wrote:
> On Thu, May 11, 2006 at 05:55:37PM +0200, J?rn Engel wrote:
> > 
> > You cannot fix a compiler warning!
> > 
> > Either the code is wrong or it is right.  A compiler warning can
> > indicate that code is wrong, or it is a false positive.  If the code
> > is wrong, fix the _code_.
> 
> Which is what the patch does, AFAICS.  What's the problem in this case?

See subject.  I didn't object to the patch, that looked fine to me.
But the general idea that a warning can be fixed always hits a loose
nerve in my brain.  Maybe I'm a bit silly in this respect.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
