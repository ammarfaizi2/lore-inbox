Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVI2W3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVI2W3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVI2W3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:29:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbVI2W3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:29:02 -0400
Date: Thu, 29 Sep 2005 15:25:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
 <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Anton Altaparmakov wrote:
> 
> Why don't you enable "enable-alternate-editor-implicitly" and set 
> editor = "your-editor-of-choice" in the pine config?  It is integrated in 
> a quite seamless way.

You think so? I don't find it that way.

With an alternate editor you have to edit the headers separately, and 
things like postponing a message suddenly turns into a big deal, not just 
a trivial ^O. In fact, almost everything gets more involved.

And pico _is_ pretty close to uemacs.

		Linus
