Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTJRGFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTJRGFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:05:46 -0400
Received: from codepoet.org ([166.70.99.138]:36760 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261346AbTJRGFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:05:45 -0400
Date: Sat, 18 Oct 2003 00:05:48 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031018060547.GA3557@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310180018.21818.rob@landley.net>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Oct 18, 2003 at 12:18:21AM -0500, Rob Landley wrote:
> I just rewrote bunzip2 for busybox in about 500 lines of C (and a good chunk 
> of that's comments), which comiles to a bit under 7k, and I was thinking of 
> redoing the bunzip-the-kernel patch with my new bunzip code, but I can't find 
> the patch.  Anybody got a URL to it?
> 
> The most recent one I could find was kerneltrap's 404-error link to 
> http://chrissicool.piranho.com/patch-2.4.x-bzip2-i386

http://shepard.kicks-ass.net/~cc/

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
