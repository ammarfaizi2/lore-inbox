Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUDJOJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUDJOJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 10:09:40 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:47830 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262041AbUDJOJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 10:09:38 -0400
Date: Sat, 10 Apr 2004 15:09:36 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: [patch] Trying to get DRM up to date in 2.6
In-Reply-To: <Pine.LNX.4.58.0404100847500.4138@skynet>
Message-ID: <Pine.LNX.4.58.0404101504530.4138@skynet>
References: <Pine.LNX.4.58.0404090838000.30863@skynet> <20040409120106.69e78838.akpm@osdl.org>
 <Pine.LNX.4.58.0404100847500.4138@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I'd say let it be checked out in Andrews tree for a while and then I'll
> ask Andrew to push it all onto Linus...
>

I'm finished mostly, all major difference between the DRM CVS and 2.6 are
in the bk tree http://freedesktop.org:1234/drm-2.6, I'll move it onto
bkbits when it arrives back on the scene, Andrew you should be able to
submit Arjans patch to Linus with this bunch and I'll do a follow up later
to make it use whatever we decide with respect to the __user, a simple
#ifndef/define might be enough...

I'm going to bed and tomorrow am taking a well deserved drinking session
:-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

