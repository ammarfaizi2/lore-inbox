Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRHIMh3>; Thu, 9 Aug 2001 08:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269785AbRHIMhT>; Thu, 9 Aug 2001 08:37:19 -0400
Received: from 50.nsc.at ([195.58.178.50]:14321 "EHLO progenius.fraser.at")
	by vger.kernel.org with ESMTP id <S269784AbRHIMhG>;
	Thu, 9 Aug 2001 08:37:06 -0400
Date: Thu, 9 Aug 2001 14:46:33 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Q: Status of AVM FritzCard PCI v2.0
Message-ID: <20010809144633.A551@freakzone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B727A9E.D7686106@commait.de>
User-Agent: Mutt/1.3.18i
X-Url: <http://www.freakzone.net/>
X-PGP-ID: 588B7D9C
From: Gordon Fraser <gordon@freakzone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Starke <starke@commait.de> [010809 13:57] wrote:
> Hi all,
> 
> I'd like to know whether the new version of AVM FritzCard PCI
> is supported in recent (i.e. 2.4.7 and above) kernels.
> We have had a problem with Linux not recognising these devices,
> but no "old" versions can be purchased any longer.

The Fritzcard PCI2.0 does not have the usual Siemens chipset so it
won't work with Hisax...but there are Capi4linux drivers at
ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/
Works with linux 2.4.x ...

Gordon

-- 
Gordon Fraser               "The number of UNIX installations
gordon@freakzone.net        has grown to 10, with more expected."
http://www.freakzone.net                                   (6/72)
