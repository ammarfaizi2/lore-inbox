Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSIFEyZ>; Fri, 6 Sep 2002 00:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIFEyZ>; Fri, 6 Sep 2002 00:54:25 -0400
Received: from [208.34.227.202] ([208.34.227.202]:31360 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S318278AbSIFEyX>; Fri, 6 Sep 2002 00:54:23 -0400
Date: Thu, 5 Sep 2002 11:00:26 -0400
From: Phil Stracchino <alaric@babcom.com>
To: Andries.Brouwer@cwi.nl
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020905150026.GA4676@babylon5.babcom.com>
Mail-Followup-To: Andries.Brouwer@cwi.nl, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <UTC200209050841.g858fmZ28242.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209050841.g858fmZ28242.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 10:41:48AM +0200, Andries.Brouwer@cwi.nl wrote:
> > Speaking of sddr09 devices (of which I possess one), what's the current
> > state of support for the sddr09?  Last I knew, at the time when I finally
> > got mine working, the sddr09 was only supported read-only
> 
> For me it works read-write and out-of-the-box on a vanilla kernel.
> (I added this stuff a few months ago. Found in 2.5 (which I use).
> Am not quite sure about 2.4.)


Hmm.  So if I was to grab 2.5.${LATEST} and try porting the sddr09
driver back to 2.4.${CURRENT} ....

Thanks for the pointer.


-- 
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.
