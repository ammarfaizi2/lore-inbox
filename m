Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUCHVfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUCHVfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:35:06 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:53475 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261262AbUCHVdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:33:52 -0500
Date: Mon, 8 Mar 2004 13:33:38 -0800
From: Paul Jackson <pj@sgi.com>
To: Grigor Gatchev <grigor@serdica.org>
Cc: mfedyk@matchmail.com, christer@weinigel.se, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
Message-Id: <20040308133338.3837fbf7.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
References: <404BE46F.1000000@matchmail.com>
	<Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While coding, think coding. While designing, think designing. Design comes
> before coding; otherwise you design while coding, and produce a mess.

You are describing, roughly, the waterfall model of software development.

Linux kernel work is closer to something resembling the prototype
and/or spiral model.

See further explanations of these terms, for instance, at:

  http://model.mercuryinteractive.com/references/models/

But, in any case, Linux kernel work _does_ have a rather extensively
articulated development model which we find is working rather well,
thank-you.  For all I know, this methodology was defined by some
traumatic event at the birth of Linus - whatever - seems to work.

When in Rome, do as the Romans.  And especially don't be surprised
at being pushed aside if you protest that we aren't behaving as the
French.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
