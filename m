Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUHYTru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUHYTru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHYTrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:47:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:27061 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268411AbUHYTnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:43:55 -0400
Date: Wed, 25 Aug 2004 12:43:08 -0700
From: Greg KH <greg@kroah.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs -> udev transition: vcsN are not created
Message-ID: <20040825194308.GC9706@kroah.com>
References: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 03:17:31PM +0300, Denis Vlasenko wrote:
> I am migrating my 2.6 systems from devfs to udev.
> Versions:
> 
> # uname -a
> Linux firebird 2.6.7-bk20 #6 Mon Jul 12 01:23:31 EEST 2004 i686 unknown

Can you try the latest -mm tree?  It should have this fixed.  I'll be
sending the patch that does this off to Linus later today.

thanks,

greg k-h
