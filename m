Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUH0TgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUH0TgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUH0Tdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:33:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:12202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267548AbUH0T3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:29:50 -0400
Date: Fri, 27 Aug 2004 12:29:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       pmarques@grupopie.com, greg@kroah.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: pwc+pwcx is not illegal
In-Reply-To: <1093634283.431.6370.camel@cube>
Message-ID: <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
References: <1093634283.431.6370.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can we drop this straw-man discussion now?

We don't do binary hooks in the kernel. Full stop. It's a gray area
legally (and whatever you say won't change that), but it's absolutely not
gray from a distribution standpoint.

AND IT WASN'T EVER THE REASON FOR REMOVING THE DRIVER IN THE FIRST PLACE!

So stop whining about it. The driver got removed because the author asked 
for it. 

		Linus
