Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUGFDwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUGFDwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 23:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGFDwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 23:52:16 -0400
Received: from mx2.magma.ca ([206.191.0.250]:8839 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S262932AbUGFDwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 23:52:14 -0400
Subject: Re: [PATCH] gcc 3.5 fixes
From: Jesse Stockall <stockall@magma.ca>
To: Mark Adler <madler@alumni.caltech.edu>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu>
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it>
	 <2ecq2-80i-1@gated-at.bofh.it>
	 <7ab39013.0407042237.40ea9035@posting.google.com>
	 <20040705064010.C9BFB5F7AA@attila.bofh.it>
	 <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu>
	 <20040705144436.62544a3d.pj@sgi.com>
	 <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu>
Content-Type: text/plain
Message-Id: <1089085868.8452.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Jul 2004 23:51:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 21:16, Mark Adler wrote:
> 
> It's not about the copyright.  I like the string kept in the object 
> code so that I and others can find out where the code is used and what 
> version is in use.  This in fact turned out to be useful when a 
> security vulnerability was found in versions 1.1.3 and earlier and a 
> script could search for executables with the offending code.
> 

<-- snip -->

> " inflate 1.1.3 Copyright 1995-1998 Mark Adler "

Did I miss something or are you saying that the version in the kernel
has a security vulnerability?

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

