Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUHXXSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUHXXSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269118AbUHXXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:18:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:38017 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269100AbUHXXS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:18:28 -0400
Date: Tue, 24 Aug 2004 16:16:54 -0700
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i8259 shutdown method for i386
Message-ID: <20040824231654.GD12613@kroah.com>
References: <m1y8ka6vz9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y8ka6vz9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:43:06AM -0600, Eric W. Biederman wrote:
> 
> Greg, 
> Now that you have added sys_device support to the generic
> device support.  This patch to shutdown the i8259A interrupt
> controller on reboot should now be safe.

This didn't apply either.  Care to send a 2.6.9-rc1 version?

Oh, and please add the "Signed-off-by:" line.

thanks,

greg k-h

