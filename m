Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSFUG3B>; Fri, 21 Jun 2002 02:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSFUG3B>; Fri, 21 Jun 2002 02:29:01 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:8973 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S316342AbSFUG27>; Fri, 21 Jun 2002 02:28:59 -0400
Date: Thu, 20 Jun 2002 23:28:43 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020621062842.GA13664@bluemug.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <200206200711.RAA10165@thucydides.inspired.net.au> <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 08:13:22AM -0700, Linus Torvalds wrote:
>
> Try it out yourself. Just do
> 
> 	mount -t driverfs /devices /devices

Doesn't "/drv" mesh better with the traditional Unix naming aesthetic?

:-)

miket
