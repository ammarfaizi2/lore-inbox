Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVFBHeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFBHeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFBHeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:34:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261393AbVFBHeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:34:01 -0400
Date: Thu, 2 Jun 2005 03:33:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Greg KH <greg@kroah.com>
cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
In-Reply-To: <20050602073303.GA9373@kroah.com>
Message-ID: <Xine.LNX.4.44.0506020329050.4151-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Greg KH wrote:

> Why not fix up the stuff that you know needs to be fixed?  It should not
> be merged until then at the least.

After that, please read Documentation/CodingStyle, 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, 
http://linux.yyz.us/patch-format.html

Break up your patch and send it in logical chunks, so it can be reviewed 
easily.


- James
-- 
James Morris
<jmorris@redhat.com>


