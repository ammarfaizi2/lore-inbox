Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUJWO4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUJWO4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUJWOvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:51:37 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:26337 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261202AbUJWOsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:48:12 -0400
Date: Sat, 23 Oct 2004 15:48:03 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
In-Reply-To: <9e47339104102307441066e4e4@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410231547410.11754@skynet>
References: <9e473391041022214570eab48a@mail.gmail.com> 
 <20041023095644.GC30137@infradead.org>  <9e473391041023073578b11eb6@mail.gmail.com>
  <20041023143912.GA32532@infradead.org> <9e47339104102307441066e4e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What about the group that will complain about the 30K of memory wasted?
>
>

they'll build their own kernel with CONFIG_AGP turned off... so it won't
matter...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

