Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265220AbTLFRyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbTLFRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:54:08 -0500
Received: from aples1.dom1.jhuapl.edu ([128.244.26.85]:5892 "EHLO
	aples1.jhuapl.edu") by vger.kernel.org with ESMTP id S265220AbTLFRyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:54:06 -0500
Message-ID: <E37E01957949D611A4C30008C7E691E2F38C26@aples3.dom1.jhuapl.edu>
From: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
To: "'Greg KH '" <greg@kroah.com>,
       "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>
Subject: RE: Visor USB hang
Date: Sat, 6 Dec 2003 12:52:52 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Greg KH wrote:
>On Thu, Dec 04, 2003 at 09:49:31AM -0500, Bernard Collins wrote:
> On Wed, 2003-12-03 at 19:24, Greg KH wrote:

> Sounds like a uhci timing issue :(

Does :( mean that it is not likely to be fixed? If so, is that because
usb-uhci is going to be deprecated in favor of uhci?

>> So is there a downside to uhci compared to usb-uhci?

> Not that I know of, it's what I use...

I did find one problem on my machine: VMware USB support depends on
usb-uhci. Oh, and my USB storage keychain device works with usb-uhci but not
uhci.

Thanks for the help.

bc
