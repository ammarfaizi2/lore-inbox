Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTLCXW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTLCXW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:22:29 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:18367 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262331AbTLCXW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:22:28 -0500
Date: Thu, 4 Dec 2003 10:27:26 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Apurva Mehta <apurva@gmx.net>, Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031203232726.GC466@gnu.org>
References: <20031203115404.GE1810@gnu.org> <Pine.LNX.4.21.0312031316550.28298-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0312031316550.28298-100000@mlf.linux.rulez.org>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 02:07:06PM +0100, Szakacsits Szabolcs wrote:
> > Can you elaborate?  Autodetect what?  Autodetect if the BIOS supports LBA?
> 
> Autodetect to boot from the boot controller's miniport driver or using
> BIOS. It should have been mentioned in one of the Microsoft articles I
> referred.

I'm totally confused.

What's a miniport driver?  What is a boot controller?  Do these have
anything to do with LBA?

Also, you say "autodetect"... you mean it is making a decision to use
some method (not that I understand this).  How does it make the decision?

The article doesn't mention "Linear", "LBA", "boot controller" or
"miniport driver" at all.  (I was looking at
http://support.microsoft.com/?kbid=98080 - is this the right one?)


The question I believe I asked was: how does the Windows installation
software decide whether to use LBA or CHS?  Is this an answer to
this question?

Cheers,
Andrew

