Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319517AbSIGUie>; Sat, 7 Sep 2002 16:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319518AbSIGUie>; Sat, 7 Sep 2002 16:38:34 -0400
Received: from [208.34.227.200] ([208.34.227.200]:42376 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S319517AbSIGUie>; Sat, 7 Sep 2002 16:38:34 -0400
Date: Sat, 7 Sep 2002 16:41:01 -0400
From: Phil Stracchino <alaric@babcom.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       usb-storage@one-eyed-alien.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020907204101.GA19588@babylon5.babcom.com>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	usb-storage@one-eyed-alien.net
References: <20020905150026.GA4676@babylon5.babcom.com> <Pine.LNX.4.33L2.0209061000410.642-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0209061000410.642-100000@ida.rowland.org>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 10:09:51AM -0400, Alan Stern wrote:
> On Thu, 5 Sep 2002, Phil Stracchino wrote:
> > Hmm.  So if I was to grab 2.5.${LATEST} and try porting the sddr09
> > driver back to 2.4.${CURRENT} ....
> >
> > Thanks for the pointer.
> 
> You might like to use the patch below, which I prepared a few weeks ago.
> It is a backport for the (more-or-less) current 2.5.x usb-storage module
> that should work under 2.4.x.  My copy of the 2.5 source is not exactly
> synched with ${LATEST}, so you may have to massage the patch a little bit
> to make it apply properly.  (Also, you have to apply the patch from within
> the linux/drivers/usb directory rather than at the top level; sorry about
> that.)


Sir, you are a scholar and a gentleman.  Thank you.  :)


-- 
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.
