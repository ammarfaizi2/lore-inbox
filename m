Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbULaRrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbULaRrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbULaRre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:47:34 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:42648 "HELO
	ogrody.nsm.pl") by vger.kernel.org with SMTP id S262122AbULaRrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:47:33 -0500
Date: Fri, 31 Dec 2004 18:48:19 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, pmarques@grupopie.com, juhl-lkml@dif.dk,
       marcelo.tosatti@cyclades.com
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231174819.GA15457@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, pmarques@grupopie.com,
	juhl-lkml@dif.dk, marcelo.tosatti@cyclades.com
References: <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost> <20041231035834.GA2421@node1.opengeometry.net> <20041231014905.30b05a11.akpm@osdl.org> <41D5376A.8000705@grupopie.com> <20041231034257.7d2f7d39.akpm@osdl.org> <20041231173643.GA2741@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231173643.GA2741@node1.opengeometry.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 12:36:43PM -0500, William Park wrote:
> My USB key drive takes 5s to show up as SCSI, from the moment 'uhci_hcd'
> and 'usb-storage' spit out message.  I don't know why.  Internally, USB
> key drive is solid state flash memory, so it should be faster than any
> spinning disks.

 USB keys driven by UB driver come up instantly.

-- 
Tomasz Torcz               RIP is irrevelant. Spoofing is futile.
zdzichu@irc.-nie.spam-.pl     Your routes will be aggreggated. -- Alex Yuriev

