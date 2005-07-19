Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVGSTkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVGSTkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVGSTkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:40:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:14519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261654AbVGSTkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:40:41 -0400
Date: Tue, 19 Jul 2005 15:40:24 -0400
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
Message-ID: <20050719194024.GA19937@kroah.com>
References: <42DD2EA4.5040507@opersys.com> <20050719192918.GA19803@kroah.com> <42DD5416.6030608@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DD5416.6030608@opersys.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 03:27:18PM -0400, Karim Yaghmour wrote:
> 
> That being said, shouldn't there be a way for the kernel to refuse to
> use this hd if it's not getting enough power. I don't know enough about
> USB to say, but isn't there something more elegant that could be done in
> software?

Nope, it's a hardware/electrical issue :)

thanks,

greg k-h
