Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLBQ6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTLBQ6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:58:11 -0500
Received: from cibs9.sns.it ([192.167.206.29]:16141 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S262323AbTLBQ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:58:08 -0500
Date: Tue, 2 Dec 2003 17:57:29 +0100 (CET)
From: venom@sns.it
To: Jeff Garzik <jgarzik@pobox.com>
cc: Darrell Michaud <dmichaud@wsi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
In-Reply-To: <20031202162808.GC22608@gtf.org>
Message-ID: <Pine.LNX.4.43.0312021753380.2317-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003, Jeff Garzik wrote:

>
> This can also be done in patch form, as it is done now :)
>

of course.
2.4 systems that are already using XFS as a patch probably would have a benefit
to see it integrated into 2.4 kernel, but they would is it anyway as a patch.

I do not think the merge would be usefull thinking to a from2.4/to2.6 upgrade.
In fact, if a system is not using XFS already, it is difficoult
that a filesystem is changed if it is an upgrade and not a reinstallation.

So, at the end, to have XFS just as a patch for 2.4 is not so bad.

Luigi

