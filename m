Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbTGOUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269654AbTGOUlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:41:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:26329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269650AbTGOUlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:41:50 -0400
Date: Tue, 15 Jul 2003 13:56:49 -0700
From: Greg KH <greg@kroah.com>
To: Michael Kristensen <michael@wtf.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715205649.GA5318@kroah.com>
References: <20030715180346.GB3843@sokrates> <20030715200707.GA581@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715200707.GA581@sokrates>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:07:07PM +0200, Michael Kristensen wrote:
> Okay, now, when I can boot the kernel (read some of the other posts in
> this thread: I have got the booting working), I have found out that the
> modules, which have unresolved symbols, can't be loaded within the
> kernel. So far, so good. These unresolved symbols. Are they kernel
> errors or are the errors on my side? What can *I* do to fix it, besides
> messing with the kernel code? Thanks.

Errors on your side.  Please install the module-init-tools package.

If you have installed that, please let us know what these errors are.

thanks,

greg k-h
