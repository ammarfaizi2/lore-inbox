Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUH0XyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUH0XyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUH0XyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:54:13 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39645 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266513AbUH0XyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:54:07 -0400
Date: Sat, 28 Aug 2004 00:54:06 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maintaining DRM and using bitkeeper..
In-Reply-To: <20040827173807.GB7445@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0408280046220.23054@skynet>
References: <Pine.LNX.4.58.0408270043170.25111@skynet>
 <20040827173807.GB7445@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Another thing you should realise is that flag-day patches are NOT welcome.
> The ongoing effort removing macors are better included in the kernel as 20
> small steps rather than 1 big patch.

This is my main issue with using bitkeeper vs separate patches, if I check
the macro conversion into bitkeeper as separate patches each removing a
couple of inter-related macros (this is my intention... it is what I did
in the DRM CVS tree) and I ask Linus to pull it from a tree, will it not
look like one big patch (albeit in a number of changesets...) - so the
patch itself will look like a flag day but the bk pull will look like a
set of patches... whereas without bk I send 20 patches to LK in 20 mails
they are nice and separated out ..

>
> May I ask why not?

well they are down the patch queue and will take me a bit of time to sort
out if the patches in front don't make it in ... though I might get to it
soon..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

