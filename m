Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUBBWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUBBWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:36:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:58816 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265877AbUBBWgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:36:07 -0500
Date: Mon, 2 Feb 2004 13:43:26 -0800
From: Greg KH <greg@kroah.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andre Noll <noll@mathematik.tu-darmstadt.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040202214326.GA574@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de> <20040130230633.GZ6577@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130230633.GZ6577@stop.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 04:06:33PM -0700, Tom Rini wrote:
> 
> Greg, I think this now makes 2 distinct bugs in the scanner kernel
> driver.  Maybe it should be protected with a BROKEN:

Very good idea, I've applied this patch.

thanks,

greg k-h
