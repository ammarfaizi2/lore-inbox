Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbUJ0Mla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUJ0Mla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUJ0Mla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:41:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42914 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262412AbUJ0MlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:41:17 -0400
Date: Wed, 27 Oct 2004 13:41:13 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg KH <greg@kroah.com>, amax@us.ibm.com, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add simple_alloc_dentry to libfs
Message-ID: <20041027124112.GB24336@parcelfarce.linux.theplanet.co.uk>
References: <Xine.LNX.4.44.0410152332330.12321-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0410152332330.12321-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:40:09PM -0400, James Morris wrote:
> This patch consolidates several occurrences of duplicated code into a new 
> libfs function simple_alloc_dentry().
> 
> Please review & apply if ok.

ACK
