Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTGBAnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTGBAnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:43:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45697 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264396AbTGBAnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:43:04 -0400
Date: Tue, 1 Jul 2003 17:57:24 -0700
From: Greg KH <greg@kroah.com>
To: Justin A <justin@bouncybouncy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb serial/visor oops in 2.4.22-pre2
Message-ID: <20030702005724.GA2337@kroah.com>
References: <1057106020.22290.17.camel@s.bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057106020.22290.17.camel@s.bouncybouncy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 08:33:40PM -0400, Justin A wrote:
> basically, pilot-xfer and all don't work anymore, dmesg reports:

But 2.4.21 works just fine for you?

What USB host driver are you using?

thanks,

greg k-h
