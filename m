Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTESXCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTESXAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:00:14 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:58125 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S263310AbTESW7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:59:50 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D3BB@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Jeffrey W. Baker'" <jwbaker@acm.org>,
       Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: RE: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Date: Mon, 19 May 2003 17:12:39 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The person who posted their DMESG had it unset.

Here's an archive of the post:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.2/0440.html

And the line:

# CONFIG_BLK_DEV_VIA82CXXX is not set 

From: Lars (lhofhansl@yahoo.com)
Date: Sun May 18 2003 - 22:03:16 EST 



--eric



-----Original Message-----
From: Jeffrey W. Baker [mailto:jwbaker@acm.org]
Sent: Monday, May 19, 2003 5:01 PM
To: Tomas Szepe; linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20


On Mon, 2003-05-19 at 15:29, Tomas Szepe wrote:
> > [alan@lxorguk.ukuu.org.uk]
> > 
> > On Llu, 2003-05-19 at 21:04, Jeffrey W. Baker wrote:
> > > I was using Via IDE chipset and, yes, I had configured the kernel for
> > > VIA support.  That's why it worked in 2.4.20.  But it stopped working
in
> > > 2.4.21-rc.
> > 
> > VIA IDE should be working reliably, my main test box is an EPIA series
> > VIA system so the VIA IDE does get a fair beating
> 
> This person is running with CONFIG_BLK_DEV_VIA82CXXX unset.

No, this person is not.  

-jwb

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
