Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUJZEuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUJZEuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUJZEqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:46:42 -0400
Received: from smtp3.oregonstate.edu ([128.193.0.12]:9132 "EHLO
	smtp3.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262134AbUJZEoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:44:23 -0400
Date: Mon, 25 Oct 2004 21:43:52 -0700
From: Greg KH <greg@kroah.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.9-mm1, kernel Ooops in visor_open
Message-ID: <20041026044351.GA12453@kroah.com>
References: <20041025144846.GA2137@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025144846.GA2137@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:48:46PM +0200, Norbert Preining wrote:
> Hi Andrew, USB developers, list!
> 
> With:
> 	linux-2.6.9-mm1
> 	debian/sid
> I get the following kernel warning:

Crud, you aren't the only one reporting this...  I'll test this out with
my visor later tomorrow and look into it.

thanks,

greg k-h
