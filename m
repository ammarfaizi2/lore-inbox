Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVCERUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVCERUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVCERUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:20:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54238 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262161AbVCERTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:19:31 -0500
Message-ID: <4229EA0A.8010608@pobox.com>
Date: Sat, 05 Mar 2005 12:19:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk>
In-Reply-To: <20050305095139.A26541@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Mar 04, 2005 at 02:05:18PM -0800, Greg KH wrote:
> 
>>On Fri, Mar 04, 2005 at 01:59:33PM -0800, Andrew Morton wrote:
>>
>>>That tree has the not-for-linus raid6 fix and the not-for-linus i8042 fix.
>>
>>Then when the authors of those patches go to submit the fix to Linus,
>>they can revert them, or bk can handle the merge properly :)
> 
> 
> How about having two BK trees - one containing "fixes for Linus" and
> the other "fixes not for Linus but we really need" ?  The "sucker
> tree" then becomes the two merged together.
> 
> This way, Linus would never see the "fixes not for Linus" at all.

Yup, BK could definitely handle that...

	Jeff




