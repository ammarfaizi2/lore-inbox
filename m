Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGGSux>; Sun, 7 Jul 2002 14:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSGGSuw>; Sun, 7 Jul 2002 14:50:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14605 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316408AbSGGSuw>;
	Sun, 7 Jul 2002 14:50:52 -0400
Date: Sun, 7 Jul 2002 19:53:25 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au
Subject: Re: [PATCH] simplify networking fcntl
Message-ID: <20020707195325.N27706@parcelfarce.linux.theplanet.co.uk>
References: <20020707171555.L27706@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73d6tzwkap.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73d6tzwkap.fsf@oldwotan.suse.de>; from ak@suse.de on Sun, Jul 07, 2002 at 06:54:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 06:54:22PM +0200, Andi Kleen wrote:
> 
> I believe James Morris did this (clean up network fcntl) already in a more 
> complex patchkit that also cleans up the SIGIO/SIGURG sending. 
> Perhaps you coordinate with him.

Last I heard from James, he was having more trouble than he expected
making it work right.  an incremental improvement didn't seem
unreasonable.

-- 
Revolutions do not require corporate support.
