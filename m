Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291875AbSBHWIS>; Fri, 8 Feb 2002 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291877AbSBHWIJ>; Fri, 8 Feb 2002 17:08:09 -0500
Received: from ran.antd.nist.gov ([129.6.51.11]:62865 "EHLO ran.antd.nist.gov")
	by vger.kernel.org with ESMTP id <S291875AbSBHWHv>;
	Fri, 8 Feb 2002 17:07:51 -0500
Date: Fri, 8 Feb 2002 17:07:46 -0500 (EST)
From: "Mark E. Carson" <carson@antd.nist.gov>
To: <linux-kernel@vger.kernel.org>
Subject: What "module license" applies to public domain code?
Message-ID: <Pine.LNX.4.30.0202081632041.16834-100000@ran.antd.nist.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a discussion awhile ago which touched briefly on this, but I
didn't see a resolution, so...

I am writing kernel module code which must (for various reasons) be
public domain.  Given that, are any of the module license strings in
include/linux/module.h appropriate for it?

I checked the version in the 2.5.3 kernel tree, and the best I could
come up with was "GPL and additional rights."  However, I couldn't find
any precise definition of this anywhere, so I'm not sure it's really
correct here.  It'd be kind of a perverse definition of "public domain,"
in any case.

Of course, anyone else would be free to take the code and apply any
license whatsoever to it, but my concern is simply what MODULE_LICENSE()
line I can legitimately include, if any.

Mark Carson	mark.carson@nist.gov	301-975-3694	Fax 301-590-0932

