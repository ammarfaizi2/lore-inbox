Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWBMT1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWBMT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWBMT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:27:24 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:48495 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964812AbWBMT1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:27:23 -0500
Message-ID: <43F0DE97.802@gentoo.org>
Date: Mon, 13 Feb 2006 19:31:35 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, dbrownell@users.sourceforge.net
Subject: Re: Linux 2.6.16-rc3
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <20060213161048.GA6137@stusta.de>
In-Reply-To: <20060213161048.GA6137@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Feb 12, 2006 at 07:05:20PM -0800, Andrew Morton wrote:
>> ...
>> - Various reports similar to
>>   http://bugzilla.kernel.org/show_bug.cgi?id=6011, seemingly related to USB
>>   PCI quirk handling.
>> ...
> 
> This bug contains a patch.
> 
> What is the status of this patch?

The patch is in Greg's tree so should see its way to Linus soon. 
However, it's not the complete fix for the general issue.

Gentoo have had two reports of it. One is fixed by David's patch, the 
other is not (http://bugs.gentoo.org/122277 - will be re-filed on kernel 
bugzilla once I have investigated more).

Daniel

