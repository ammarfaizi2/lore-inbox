Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUL2JZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUL2JZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 04:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbUL2JZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 04:25:19 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:27597 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261331AbUL2JZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 04:25:06 -0500
Date: Wed, 29 Dec 2004 09:25:01 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: running Linus kernel on FC3 
In-Reply-To: <200412290920.iBT9KcCq026840@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0412290922420.2899@skynet>
References: <Pine.LNX.4.58.0412290853540.2899@skynet>
 <200412290920.iBT9KcCq026840@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This would be a lot easier to answer if you actually told us what the
> warnings were.

Well I thought people might be seeing the same things... it's just Linus
kernel with FC3 config....

lots of things like:.. some ntpd ones as well..
audit(1104309139.067:0): avc:  denied  { write } for  pid=3222
exe=/sbin/minilogd name=/ dev=tmpfs ino=464
scontext=user_u:system_r:syslogd_t tcontext=user_u:object_r:tmpfs_t
tclass=dir

RH have said before that they try to keep their Fedora kernels as close to
Linus as possible, just wondering is this one area they've gone their own
way..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

