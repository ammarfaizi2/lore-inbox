Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbTL2XBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTL2XBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:01:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:19128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265155AbTL2XBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:01:51 -0500
Date: Mon, 29 Dec 2003 15:01:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Shawn <core@enodev.com>, Stef van der Made <svdmade@planet.nl>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-mm2
In-Reply-To: <20031229224846.GK1882@matchmail.com>
Message-ID: <Pine.LNX.4.58.0312291458260.1586@home.osdl.org>
References: <20031229013223.75c531ed.akpm@osdl.org> <3FF08057.7010405@planet.nl>
 <1072729484.8769.1.camel@www.enodev.com> <20031229224846.GK1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Mike Fedyk wrote:
> 
> I think Linus will be releasing the 2.6-pre kernels, and things will
> continue like that until 2.7 opens up.

Indeed. The fact is, we do need a "testing ground" for some experimental
fixes to stuff that needs to be fixed, and that's one of the things the
-mm kernels used to do for 2.5.x.

Since everybody was pretty comfy with that setup, we'll just continue that 
way. By the time 2.7.x opens up, things should have calmed down, and 
commercial vendors have their support trees in shape etc, but for now the 
-mm tree is a testing ground, and I'll make -pre trees that should be 
fairly stable, and then we'll do the 2.6.1 etc "real releases" based off 
them.

		Linus
