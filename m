Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVCITBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVCITBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCIS7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:59:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:22218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262187AbVCIS7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:23 -0500
Date: Wed, 9 Mar 2005 10:58:53 -0800
From: Greg KH <greg@kroah.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kai.makisara@kolumbus.fi
Subject: Re: [patch 5/5] make st seekable again
Message-ID: <20050309185853.GE27268@kroah.com>
References: <200503042117.j24LHJLM017976@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHJLM017976@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:58PM -0800, akpm@osdl.org wrote:
> 
> From: Kai Makisara <kai.makisara@kolumbus.fi>
> 
> Apparently `tar' errors out if it cannot perform lseek() against a tape.  Work
> around that in-kernel.
> 
> Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Added to the -stable queue, thanks.

greg k-h

