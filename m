Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbVKPUIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVKPUIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVKPUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:08:42 -0500
Received: from [212.76.86.25] ([212.76.86.25]:14607 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030484AbVKPUIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:08:41 -0500
From: Al Boldi <a1426z@gawab.com>
To: Shaya Potter <spotter@cs.columbia.edu>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Wed, 16 Nov 2005 23:05:31 +0300
User-Agent: KMail/1.5
Cc: torvalds@osdl.org, linuxram@us.ibm.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       rob@landley.net, Miklos Szeredi <miklos@szeredi.hu>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu> <1132149576.8155.23.camel@localhost.localdomain>
In-Reply-To: <1132149576.8155.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511162303.33103.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> I created a patch years ago that creates a chain of "chroot" points, and
> any past chroot point would be considered a place that follow_dotdot
> would consider a root.  There didn't seem much interest in the patch
> though.

Could you resubmit this patch for possible inclusion in 2.6.16, and make it a 
runtime option such that the default behaviour remains unchanged?

Thanks!!!

--
Al
