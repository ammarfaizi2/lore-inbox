Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267822AbUHJXdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267822AbUHJXdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUHJXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:32:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:43143 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267818AbUHJXbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:31:12 -0400
Date: Tue, 10 Aug 2004 16:28:15 -0700
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export legacy pty info via sysfs
Message-ID: <20040810232815.GB21483@kroah.com>
References: <20040810135402.GA5459@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810135402.GA5459@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:54:02PM +0200, Olaf Hering wrote:
> 
> You missed that one last year.
> 
> 
> export the legacy pty/tty device nodes via sysfs,
> so udev has a chance to create them if /dev is in tmpfs.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Applied, thanks.

greg k-h
