Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFTA7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTFTA7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:59:25 -0400
Received: from 12-222-225-127.client.insightBB.com ([12.222.225.127]:21405
	"EHLO dirac.s-z.org") by vger.kernel.org with ESMTP id S262116AbTFTA7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:59:24 -0400
From: Neil Moore <neil@s-z.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16114.24500.590079.152861@dirac.s-z.org>
Date: Thu, 19 Jun 2003 21:13:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Unix code in Linux
In-Reply-To: <bctg2u$75s$1@news.cistron.nl>
References: <E19T87m-000367-SF@dirac.s-z.org>
	<bctg2u$75s$1@news.cistron.nl>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg writes:
> The source being online is possible because the V1 - V7 source was
> put under a BSD-like license by Caldera in 2002. A copy of the license
> is still at ftp://minnie.tuhs.org/UnixArchive/Caldera-license.pdf
> 
> (there's much more at ftp://minnie.tuhs.org/UnixArchive/, including
> V6, V7 and 2.11BSD source).
> 
> So, in this particular case this doesn't seem to be a problem.

The license to which you referred says, in part:

Copyright(C) Caldera International Inc. 2001-2002. All rights
reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

[. . .] Redistributions of source code and documentation must retain the above
copyright notice, this list of conditions and the following
disclaimer. [. . .]


The file in question in the Kernel does not include any Caldera
copyright notice, and in fact claims that the copyright belongs to
SGI.  Isn't that a violation of Caldera's copyright?  

Of course, if SGI has an unlimited right to relicense Unix code as its
own, it's not an issue.

-- 
Neil Moore: neil@s-z.org, http://s-z.org/~neil/
