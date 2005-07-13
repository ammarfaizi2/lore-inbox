Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVGMA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVGMA2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGMA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:28:47 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:52438 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262258AbVGMA1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:27:21 -0400
Date: Tue, 12 Jul 2005 20:23:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.13-rc2-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507122027_MC3-1-A44F-D6F8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I downloaded 2.6.13-rc2-mm2-broken-out.tar.bz2 and verified the signature.

Then I untarred it and moved it to the patches/ dir.

Output of 'quilt push -a' ends with:

    Applying git-netdev-janitor-fixup.patch
    patch: **** Only garbage was found in the patch input.
    Patch git-netdev-janitor-fixup.patch does not apply (enforce with -f)


There were also a slew of patches that applied with offset errors before that.

Is the broken-out tarfile supposed to be usable like this?


--
Chuck
