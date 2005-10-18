Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVJRUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVJRUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVJRUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:12:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:51899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751462AbVJRUM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:12:58 -0400
Date: Tue, 18 Oct 2005 13:12:26 -0700
From: Greg KH <greg@kroah.com>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Damir Perisa <damir.perisa@solnet.ch>
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/
Message-ID: <20051018201226.GA31705@kroah.com>
References: <20051016154108.25735ee3.akpm@osdl.org> <200510171229.57785.damir.perisa@solnet.ch> <4353BB87.1030006@us.ibm.com> <200510171721.26588.damir.perisa@solnet.ch> <43550078.1060105@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43550078.1060105@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 09:02:32AM -0500, V. Ananda Krishnan wrote:
> Hi all,
> 
>  Can some one send me pointer(s) to the recent API changes in the tty 
> layer that has gone in to linux-2.6.14.xxx.

You have access to the patches as well as we do. :)

Anyway, the changes are only in the -mm tree for now, not in the
mainline kernel.  Look at the patches there, they should be pretty
obvious.

thanks,

greg k-h
