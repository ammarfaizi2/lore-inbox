Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUHZJ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUHZJ6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUHZJyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:54:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:43421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268033AbUHZIrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:47:42 -0400
Date: Thu, 26 Aug 2004 01:45:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826014542.4bfe7cc3.akpm@osdl.org>
In-Reply-To: <412D9FE6.9050307@namesys.com>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<412D9FE6.9050307@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
>  >To get us started on this route it would really help me (and, probably,
>  >others) if you could describe what these API extensions are in a very
>  >simple way, without referring to incomprehehsible web pages,
>  >
>  what is not comprehensible....?

Pretty much anything at www.namesys.com.  The amount of time which is
needed to extract the technical info which one is looking for vastly
exceeds a gnat-like attention span.

As a starting point, please prepare a bullet-point list of
userspace-visible changes which the filesystem introduces, or is planned to
introduce.

And describe the "plugin" system.  Why does the filesystem need such a
thing (other filesystems get their features via `patch -p1')?

And what are the licensing implications of plugins?  Are they derived
works?  Must they be GPL'ed?

