Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWKBPFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWKBPFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWKBPFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:05:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56760 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751234AbWKBPFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:05:53 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Linux
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Small optimization for nfs3acl.   (was: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL deref and tiny optimization.)
Date: Thu, 2 Nov 2006 16:06:36 +0100
User-Agent: KMail/1.9.5
Cc: David Rientjes <rientjes@cs.washington.edu>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
References: <200610272316.47089.jesper.juhl@gmail.com> <200610311726.00411.agruen@suse.de> <200610312139.23836.jesper.juhl@gmail.com>
In-Reply-To: <200610312139.23836.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021606.36447.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 21:39, Jesper Juhl wrote:
> Here's a patch for nfs3. Hope it's OK.

It's obviously correct.

Thanks,
Andreas
