Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWCJRJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWCJRJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbWCJRJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:09:25 -0500
Received: from valinor.lockfile.org ([195.149.74.78]:20353 "EHLO
	valinor.lockfile.org") by vger.kernel.org with ESMTP
	id S1751874AbWCJRJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:09:24 -0500
Message-ID: <4411B2C1.40307@lockfile.org>
Date: Fri, 10 Mar 2006 18:09:21 +0100
From: Jason Brian Friedrich <mail@lockfile.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Booting Kernel 2.6.15 let the machine freeze completely
References: <4410B86E.9060809@lockfile.org> <20060310003213.GA7789@mipter.zuzino.mipt.ru>
In-Reply-To: <20060310003213.GA7789@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

> Brave Fedora users comment more:

I do not know what you exactly mean with this phrase, but it sounds a 
bit odd. This is a problem just related to Fedora. After i read the 
comments you posted (thanks for that), i assume that it is also related 
to Ubuntu, Gentoo, OpenSuSE and any other distribution using 2.6.15 as 
default kernel for the installation.

Or did i misunderstand you in this point?

> [Comments from users describing the same problem]
> -----------------------------------------------------------------------
> Try these boot options at startup:
> noapic acpi=off nofb
> -----------------------------------------------------------------------
> It Worked!
> -----------------------------------------------------------------------

Nope. I added the option 'nofb' to the parameters i already mentioned in 
my last message. But the problem still exists, no change so far.

Regards,
  Jason
