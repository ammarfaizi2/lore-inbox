Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbTCZNRA>; Wed, 26 Mar 2003 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbTCZNRA>; Wed, 26 Mar 2003 08:17:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34999
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261682AbTCZNQ7>; Wed, 26 Mar 2003 08:16:59 -0500
Subject: RE: Boot/reboot cycle on startup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl Gherardi <Carl.Gherardi@nautronix.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CDF67C45E6F8384B996AC26A3B8057824F86AB@exch-fremantle.nautronix>
References: <CDF67C45E6F8384B996AC26A3B8057824F86AB@exch-fremantle.nautronix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048689710.31837.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 14:41:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 01:27, Carl Gherardi wrote:
> Thanks
> 
> Hadn't realized the VIA chips weren't full clones.

The C3 is a fully features "i686" base definition. It doesn't have
the Athlon goodies like prefetching, cmov etc. The optimal kernel
for it is the C3 specific one, or for a generic kernel i486

