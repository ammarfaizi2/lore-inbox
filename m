Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSDWRQa>; Tue, 23 Apr 2002 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSDWRQ3>; Tue, 23 Apr 2002 13:16:29 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:42769 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S315265AbSDWRQ1>; Tue, 23 Apr 2002 13:16:27 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A77B0@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'James L Peterson'" <peterson@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: RE: PowerPC Linux and PCI
Date: Tue, 23 Apr 2002 10:16:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James L Peterson wrote: 
> 
> "David S. Miller" wrote:
> > 
> > An important point to mention is that big endian systems need to do
> > byte twisting in the PCI controller for all the byte-lane issues to
> > work out properly.
> 
> What does this mean?  This suggests that PCI controller for
> big-endian systems are not interchangeable with PCI controllers
> for little-endian systems, because the controller itself does
> byte swapping (is that what you mean by "byte twisting"?)

I think David's reference is to the system's PCI subsystem/interface rather
than to the PCI cards plugged into it.

Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

