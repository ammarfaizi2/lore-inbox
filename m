Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUDBWjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDBWjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:39:09 -0500
Received: from dsl206.fmt.bevcomm.net ([206.146.76.206]:35991 "EHLO
	thebrain.conmicro.cx") by vger.kernel.org with ESMTP
	id S261239AbUDBWjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:39:05 -0500
Date: Fri, 2 Apr 2004 16:40:20 -0600
From: Jay Maynard <jmaynard@conmicro.cx>
To: Greg KH <greg@kroah.com>
Cc: Stefan Wanner <stefan.wanner@postmail.ch>, linux-alpha@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: SCSI generic support: Badness in kobject_get
Message-ID: <20040402224020.GA8590@thebrain.conmicro.cx>
References: <7CA30FDE-84F1-11D8-8FED-000393C43976@postmail.ch> <20040402223550.GA12467@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402223550.GA12467@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:35:50PM -0800, Greg KH wrote:
> On Sat, Apr 03, 2004 at 12:02:52AM +0200, Stefan Wanner wrote:
> > I have an Alpha AS400 with Debian Linux 3.0 and Kernel 2.6.3
> Please use a newer kernel, this bug has been fixed in 2.6.4.

Not on my system...I still get them.

Also, is there any significance to the piles of "wrong section name for
.got" messages I get when compiling modules?
