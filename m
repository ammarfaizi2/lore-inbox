Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWIMTTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWIMTTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWIMTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:19:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11665 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751140AbWIMTTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:19:43 -0400
Subject: Re: - r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch removed
	from -mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
       mm-commits@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060913191217.GJ8792@ca-server1.us.oracle.com>
References: <200609130506.k8D56U3m018878@shell0.pdx.osdl.net>
	 <20060913182716.GI8792@ca-server1.us.oracle.com>
	 <1158172596.9141.91.camel@localhost.localdomain>
	 <20060913191217.GJ8792@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 12:18:41 -0700
Message-Id: <1158175121.9141.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 12:12 -0700, Mark Fasheh wrote:
> > Now that the vote call is gone, I don't think we even use future_nlink.
> > Can we just kill this entire section?
> Yeah, good catch. Lets try this one again...

Looks good to me.  Thanks a bunch for updating this one.

Signed-off-by:  Dave Hansen <haveblue@us.ibm.com>

-- Dave

