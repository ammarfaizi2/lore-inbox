Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbUCZAhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263889AbUCZAgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:36:38 -0500
Received: from sa-4.airstreamcomm.net ([64.33.192.164]:26898 "EHLO
	sa-4.airstreamcomm.net") by vger.kernel.org with ESMTP
	id S263817AbUCZA2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:28:13 -0500
To: 239952@bugs.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de>
	<20040325082949.GA3376@gondor.apana.org.au>
	<20040325220803.GZ16746@fs.tum.de> <40635DD9.8090809@pobox.com>
	<40636302.6080807@stesmi.com>
From: John Hasler <john@dhh.gt.org>
Date: Thu, 25 Mar 2004 18:33:50 -0600
In-Reply-To: <40636302.6080807@stesmi.com> (Stefan Smietanowski's message of
 "Thu, 25 Mar 2004 23:53:54 +0100")
Message-ID: <87lllobg5t.fsf@toncho.dhh.gt.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan writes:
> Except the firmware itself is GPL in this case.

So the problem is not GPL compatibility: it's GPL code being distributed
without source.  Can we get written permission from the manufacturer?
Without either source or written permission to do without we cannot
redistribute.

Note that the GPL does not require that the firmware build from source on
Linux.  We are not obligated (by the GPL) to supply a compiler.
-- 
John Hasler               You may treat this work as if it 
john@dhh.gt.org           were in the public domain.
Dancing Horse Hill        I waive all rights.
Elmwood, Wisconsin
