Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbTJGTlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTJGTlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:41:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:50584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262759AbTJGTll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:41:41 -0400
Date: Tue, 7 Oct 2003 12:41:24 -0700
From: Greg KH <greg@kroah.com>
To: insecure <insecure@mail.od.ua>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031007194124.GA2670@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <yw1xllrxdvhh.fsf@users.sourceforge.net> <200310072128.09666.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310072128.09666.insecure@mail.od.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 09:28:09PM +0300, insecure wrote:
> 
> What am I supposed to do, starting to use mknod again? Uggggh...

Provide me with a kernel name to devfs name mapping file so that I can
create a "devfs like" udev config file for people who happen to like
that naming scheme.

thanks,

greg k-h
