Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTJNGlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTJNGlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:41:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:1168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbTJNGlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:41:19 -0400
Date: Mon, 13 Oct 2003 23:44:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org, vs@thebsh.namesys.com,
       nikita@namesys.com
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-Id: <20031013234438.00599b00.akpm@osdl.org>
In-Reply-To: <3F8B9820.6010208@namesys.com>
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
	<20031012071447.GJ8724@pegasys.ws>
	<3F8A3CE0.4060705@namesys.com>
	<20031013032431.1ed40c25.akpm@osdl.org>
	<3F8B93F7.2020805@namesys.com>
	<20031013232527.3cf5701f.akpm@osdl.org>
	<3F8B9820.6010208@namesys.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> >Yes, John has a point but we're not going to go and change all the other
>  >filesystems (are we?).
>  >
>  >
>  >
>  >  
>  >
>  why not?  It is correct therefor....

Because that's the way we've always done it and there have been zero
complaints about it and changing it risks breaking things.

I should think that's pretty obvious?
