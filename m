Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTH1SmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTH1SmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:42:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:26568 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264123AbTH1SmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:42:11 -0400
Date: Thu, 28 Aug 2003 11:28:16 -0700
From: Greg KH <greg@kroah.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][resend] 2/13 2.4.22-rc2 fix __FUNCTION__ warnings drivers/hotplug
Message-ID: <20030828182816.GD12031@kroah.com>
References: <20030822035245.0940b4bd.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822035245.0940b4bd.vmlinuz386@yahoo.com.ar>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:52:45AM -0300, Gerardo Exequiel Pozzi wrote:
> Hi people,
> this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

Applied to my trees, I'll send it on to Marcelo in a bit.

thanks,

greg k-h
