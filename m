Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUA3Tcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUA3Tcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:32:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:52964 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263486AbUA3Tcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:32:41 -0500
X-Authenticated: #4512188
Message-ID: <401AB157.1040209@gmx.de>
Date: Fri, 30 Jan 2004 20:32:39 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: khubd crash on scanner disconnect
References: <20040130173656.GA4570@merlin.emma.line.org> <20040130191453.GA7173@kroah.com>
In-Reply-To: <20040130191453.GA7173@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jan 30, 2004 at 06:36:56PM +0100, Matthias Andree wrote:
> 
>>Hi,
>>
>>I have just caught this khubd NULL dereference simply by unplugging my
>>scanner. Kernel is a current 2.6.2-rc2 from BK, PNP enabled:
> 
> 
> Known bug, don't use that module, it's OBSOLETED.  Use xscane and libusb
> instead.

Are you sure, it is "xscane" and not "xsane"? I thought you just did a 
typo in my post, but now you did it twice, so no typo?

Prakash
