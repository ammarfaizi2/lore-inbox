Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269108AbUHXXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269108AbUHXXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUHXXTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:19:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:40577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269111AbUHXXSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:18:33 -0400
Date: Tue, 24 Aug 2004 16:16:28 -0700
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add sysfs support for the i8259 PIC on x86_64
Message-ID: <20040824231628.GC12613@kroah.com>
References: <m13c2i8ani.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13c2i8ani.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:40:49AM -0600, Eric W. Biederman wrote:
> 
> I got to looking at x86_64 and while it occasionally uses the i8259 legacy
> pic it is not put in sysfs.
> 
> Here is the appropriate code ported code from i386.

Hm, this doesn't apply at all.  Any chance of redoing it for 2.6.9-rc1?

thanks,

greg k-h
