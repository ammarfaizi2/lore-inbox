Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbTIJVCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265730AbTIJVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:02:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:62376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265729AbTIJVCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:02:44 -0400
Date: Wed, 10 Sep 2003 14:09:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Subodh Shrivastava <subodh@btopenworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
In-Reply-To: <3F5F814D.1080800@btopenworld.com>
Message-ID: <Pine.LNX.4.44.0309101407450.19541-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any chance of this  patch to be released against mm series? BTW i have 
> tried suspend to disk (2.6.0-test4-mm6) with reiserfs filesystem
> it worked fine and no fs corruption.

Good to hear. Thanks for testing. 

Andrew picked up the last bunch of patches for the -mm series, so most of
it already resides in that tree. With some luck, he'll do the same with
the remaining patches. Otherwise, I can post an incremental patch on top 
of the latest -mm kernel.


	Pat

