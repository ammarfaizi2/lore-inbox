Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTLJCIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTLJCIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:08:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:16606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263176AbTLJCH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:07:58 -0500
Date: Tue, 9 Dec 2003 16:41:20 -0800
From: Greg KH <greg@kroah.com>
To: Svetoslav Slavtchev <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in kobject_get at lib/kobject.c:439
Message-ID: <20031210004120.GB2196@kroah.com>
References: <31894.1071016585@www6.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31894.1071016585@www6.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 01:36:25AM +0100, Svetoslav Slavtchev wrote:
> 
> the attached oops couldn't happen in vanilla kernel ?
> or should i try without the ruby patches ?

Can you try it without the ruby patches?  I have no idea what is
contained in them.

thanks,

greg k-h
