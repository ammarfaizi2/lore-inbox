Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVFBOpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVFBOpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVFBOoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:44:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:25058 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbVFBOmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:42:54 -0400
Date: Thu, 2 Jun 2005 07:51:54 -0700
From: Greg KH <greg@kroah.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602145153.GA12565@kroah.com>
References: <20050602073303.GA9373@kroah.com> <Xine.LNX.4.44.0506020329050.4151-100000@thoron.boston.redhat.com> <20050602123219.GB8855@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602123219.GB8855@halcrow.us>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 07:32:19AM -0500, Michael Halcrow wrote:
> What sort of
> logical chunks would you consider to be appropriate?  Separate patches
> for each file (inode.c, file.c, super.c, etc.), which represent sets
> of functions for each major VFS object?

Yes.

thanks,

greg k-h
