Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVC2F3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVC2F3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC2F3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:29:51 -0500
Received: from irc.sh.nu ([216.239.132.110]:61847 "EHLO mail.3gstech.com")
	by vger.kernel.org with ESMTP id S262293AbVC2F3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:29:31 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Aaron Gyes <floam@sh.nu>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050329044533.GG7362@kroah.com>
References: <1111886147.1495.3.camel@localhost>
	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	 <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost>
	 <20050329033350.GA6990@kroah.com> <1112070511.32594.4.camel@localhost>
	 <20050329044533.GG7362@kroah.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 21:29:30 -0800
Message-Id: <1112074170.3358.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 20:45 -0800, Greg KH wrote:

> What do you mean by "static"?  Something that persists over a reboot?
> Or after the device is removed?

Forgot to clarify. Create a node for something that's not in sysfs, with
udev.

