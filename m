Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUBCA4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUBCA4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:56:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:33413 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265376AbUBCA40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:56:26 -0500
Date: Mon, 2 Feb 2004 16:56:18 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040203005618.GA2340@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 03:58:56PM -0800, Woodruff, Robert J wrote:
> 
> I'd also like to hear from the linux-kernel folks on what we would need
> to do to get a basic InfiniBand access layer included in the 2.6 base. 

How about submitting a patch to lkml that follows the guidelines in
Documentation/SubmittingPatches and Documentation/CodingStyle?  That
would be a good start...

thanks,

greg k-h
