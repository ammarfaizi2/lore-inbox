Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUBXTDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUBXTDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:03:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:11967 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262408AbUBXTDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:03:20 -0500
Date: Tue, 24 Feb 2004 10:45:51 -0800
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@ltcfwd.linux.ibm.com.kroah.org>
Cc: johnrose@austin.ibm.com, linux-kernel@vger.kernel.org, gregkh@us.ibm.com,
       lxie@us.ibm.com, wortman@us.ibm.com, scheel@us.ibm.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATH]  rpaphp_fixes. patch
Message-ID: <20040224184551.GE32383@kroah.com>
References: <200402110112.i1B1CToT022755@localhost.localdomain> <20040218205741.GB5175@kroah.com> <40367EB4.1090606@ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40367EB4.1090606@ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 03:40:04PM -0600, Linda Xie wrote:
> Hi Greg,
> 
> 
> Greg KH wrote:
> 
> >Applied, thanks.
> >
> >greg k-h
> >
> The attached patch has a fix for the conflict between  fakephp and 
> rpaphp so that fakephp and
> rpaphp can't be built into the kernel at the same time and a couple of  
> problems
> I missed in my previous patch. (Sorry about that).

Applied, thanks.

greg k-h
