Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDBWgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUDBWgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:36:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:18883 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbUDBWgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:36:01 -0500
Date: Fri, 2 Apr 2004 14:35:50 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Wanner <stefan.wanner@postmail.ch>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: SCSI generic support: Badness in kobject_get
Message-ID: <20040402223550.GA12467@kroah.com>
References: <7CA30FDE-84F1-11D8-8FED-000393C43976@postmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CA30FDE-84F1-11D8-8FED-000393C43976@postmail.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 12:02:52AM +0200, Stefan Wanner wrote:
> Hi
> 
> I have an Alpha AS400 with Debian Linux 3.0 and Kernel 2.6.3

Please use a newer kernel, this bug has been fixed in 2.6.4.

thanks,

greg k-h
