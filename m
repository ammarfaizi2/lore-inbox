Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWJGUQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWJGUQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbWJGUQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:16:50 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:51363 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932795AbWJGUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:16:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=qGAKa4IgOgUU9nn3EmQY+CxFzVRi34FWiHCromnJGCIys7/6ryft4uz69Qjeglig87rRALEULytQ3LE+HMbd02PUJAlu/ToOPOS4l/cxzIHeVpb9k7xg4zKar0kjRgTIv0gf5uyKkGDngnt2RiITV3Ql71yqPc4Z5LBZ8a7Ygf4=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 1/3] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Date: Sat, 7 Oct 2006 13:16:44 -0700
User-Agent: KMail/1.7.1
Cc: Arnd Bergmann <arnd@arndb.de>, dbrownell@users.sourceforge.net,
       support@moschip.com, Michael Helmling <supermihi@web.de>,
       linux-kernel@vger.kernel.org, David Hollis <dhollis@davehollis.com>
References: <200609170102.50856.arnd@arndb.de> <200609271828.58205.david-b@pacbell.net> <200610072058.26162.arnd@arndb.de>
In-Reply-To: <200610072058.26162.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071316.45545.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 October 2006 11:58 am, Arnd Bergmann wrote:
> On Thursday 28 September 2006 03:28, David Brownell wrote:
> > On Saturday 16 September 2006 4:02 pm, Arnd Bergmann wrote:
> > > This driver adds support for the DeLOCK USB ethernet adapter
> > > and potentially others based on the MosChip MCS7830 chip.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 
> 
> David, I was under the assumption that you would submit this version
> for inclusion in 2.6.19. Do you have it queued somewhere for submission
> or did you expect me to send it to someone else?

I was expecting Greg to do his usual fine job and pick it up
for his next set of USB patches.  But you could probably
speed the process up by resending it to him.  2.6.19 seems
right to me.  (Hmm, I don't think your other two patches
got merged either ...)

- Dave
