Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUG0E6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUG0E6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUG0E6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:58:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32653 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265301AbUG0E6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:58:35 -0400
Date: Mon, 26 Jul 2004 21:57:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: akpm@osdl.org, achew@nvidia.com, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Message-Id: <20040726215738.5c4a8b42.pj@sgi.com>
In-Reply-To: <1090902426.1094.33.camel@mindpipe>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
	<20040726173806.7cc0e9d5.akpm@osdl.org>
	<1090902426.1094.33.camel@mindpipe>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For now the only fix for people using an X environment ... insert file ...

Another fix is to copy from a non-brain damaged window, such as a gui
text editor window (nedit, for example).

I'm guessing that the tabs are lost in the cut or copy operation, not in
the paste operation.

But file insertion is, in general, a sufficiently winning choice that I
think it's better just to get in the habit of always inserting patches
that way, at least on email clients that support it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
