Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTJNX7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTJNX7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:59:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:14484 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbTJNX7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:59:50 -0400
Date: Tue, 14 Oct 2003 16:54:36 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] add USB gadget Configure help entries
Message-ID: <20031014235436.GC18311@kroah.com>
References: <20031011120508.GU24300@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011120508.GU24300@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 02:05:08PM +0200, Adrian Bunk wrote:
> In 2.4.23-pre7 USB gadget support was added but no Configure.help 
> entries were added.
> 
> The patch below adds these missing entries. the help texts were copied 
> from 2.6, please check whether they are correct for 2.4, too.

Applied, thanks.

greg k-h
