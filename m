Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUH3WYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUH3WYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUH3WYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:24:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43215 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264639AbUH3WYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:24:14 -0400
Message-ID: <4133A900.90906@pobox.com>
Date: Mon, 30 Aug 2004 18:24:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Bennett <Robert.Bennett2@ca.com>
CC: apkm@osdl.org, linux-kernel@vger.kernel.org, kgem-devel@lists.sf.net
Subject: Re: [ANNOUNCE] Kernel Generalized Event Management
References: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
In-Reply-To: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Bennett wrote:
> Respectfully submitted for evaluation and comments...
> 
> Kernel Generalized Event Management (KGEM) is an experimental facility for
> collecting kernel events and managing user mode applications that are
> interested in these events.  A kernel event can be anything that happens in the
> kernel that an application may be interested in, such as a file being opened, a
> program being executed, a process being created, etc.  KGEM provides a
> structure for defining these events and delivering them to listening
> applications in user space.  


Just use netlink.  It's already in the kernel.

	Jeff

