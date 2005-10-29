Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVJ2DRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVJ2DRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVJ2DRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:17:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:29077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751116AbVJ2DRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:17:34 -0400
Date: Fri, 28 Oct 2005 20:17:06 -0700
From: Greg KH <greg@kroah.com>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, rml@novell.com
Subject: Re: Kernel Badness 2.6.14-Git
Message-ID: <20051029031706.GA26123@kroah.com>
References: <4362BFF1.3040304@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4362BFF1.3040304@linuxwireless.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 06:18:57PM -0600, Alejandro Bonilla Beeche wrote:
> Hi,
> 
>    I just pulled from Linus Tree and I'm getting this badness in dmesg.
> 
> Please let me know if it is too soon to start reporting this. 2.6.14 is 
> OK and does not output this.

If you disable PNP does it go away?

Dmitry, any thoughts?  This looks like the other reported issue.

thanks,

greg k-h
