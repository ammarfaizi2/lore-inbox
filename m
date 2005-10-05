Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVJEO5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVJEO5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVJEO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:57:38 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:3464 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965196AbVJEO5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:57:37 -0400
Date: Wed, 5 Oct 2005 10:57:36 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Marc Perkel <marc@perkel.com>, Nix <nix@esperi.org.uk>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005145736.GB7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <Pine.LNX.4.61.0510051048090.5182@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510051048090.5182@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 10:52:59AM -0400, linux-os (Dick Johnson) wrote:
> Also it has nothing at all to do with the kernel. It's what `ls`
> or some other directory-reading program provides for the user.
> People often forget that PATH, `pwd`, etc., are just filter
> components!
> 
> When you `cd` to somewhere, your location hasn't changed at
> all!

So what does bash do that makes the new location 'busy' when you cd to
it such that you can't unmount it?

> Without involving the kernel, one can make any kind of filter
> to cause any sort of display that you want.

An it certainly is something that should be done in user space.

Len Sorensen
