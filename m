Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267086AbUBEXDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267089AbUBEXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:03:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:34183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267086AbUBEXBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:01:16 -0500
Date: Thu, 5 Feb 2004 14:54:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: hch@infradead.org, sean.hefty@intel.com, ftillier@infiniconsys.com,
       cfriesen@nortelnetworks.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, hozer@hozed.org, woody@jf.intel.com,
       bill.magro@intel.com, infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
 theLinux kernel
Message-Id: <20040205145434.35608ba6.rddunlap@osdl.org>
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3685@orsmsx410.jf.intel.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3685@orsmsx410.jf.intel.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 14:55:54 -0800 "Woodruff, Robert J" <woody@co.intel.com> wrote:

| I think what started the discussion was that
| if anyone wanted to look at the code and start to comment 
| before we have a 2.6 patch ready they can download it from bitkeeper at
| 
| http://infiniband.bkbits.net/iba

Not Found
The requested URL /iba was not found on this server.


| or if you want, I could post a tar ball of the latest BK change set on
| sourceforge,
| or you can wait till we make all the changes to the makefiles, etc, to
| allow it to 
| easily integrate into the 2.6 build environment.
| 
| Any preference ?

yes, tarball for me....

Thanks,   [and please don't top-post]
---
~Randy


| -----Original Message-----
| From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
| Sent: Thursday, February 05, 2004 2:40 PM
| To: Christoph Hellwig
| Cc: Hefty, Sean; ftillier@infiniconsys.com; cfriesen@nortelnetworks.com;
| greg@kroah.com; linux-kernel@vger.kernel.org; hozer@hozed.org;
| woody@jf.intel.com; Magro, Bill; woody@jf.intel.com;
| infiniband-general@lists.sourceforge.net
| Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
| theLinux kernel
| 
| 
| On Thu, 5 Feb 2004 22:40:43 +0000 Christoph Hellwig <hch@infradead.org>
| wrote:
| 
| | On Thu, Feb 05, 2004 at 02:26:46PM -0800, Hefty, Sean wrote:
| | > Personally, I'm amazed that professional developers have to discuss 
| | > or defend modular, portable code.
| | > 
| | > Once the code has been submitted, then specific implementation 
| | > problems can be dealt with.
| | 
| | *plonk*
| 
| 
| Christoph, he didn't say merged.  Let them submit it for review... and
| then comment on it.
| 
| --
