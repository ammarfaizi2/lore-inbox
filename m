Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWFNO3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWFNO3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWFNO3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:29:08 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:19819 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S964983AbWFNO3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:29:06 -0400
Date: Wed, 14 Jun 2006 16:29:04 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Daniel Phillips <phillips@google.com>, bidulock@openss7.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614142903.GI11542@harddisk-recovery.com>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060614133022.GU11863@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614133022.GU11863@sunbeam.de.gnumonks.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 03:30:22PM +0200, Harald Welte wrote:
> On Tue, Jun 13, 2006 at 02:12:41PM -0700, Daniel Phillips wrote:
>  
> > This has the makings of a nice stable internal kernel api.  Why do we want
> > to provide this nice stable internal api to proprietary modules?
> 
> because there is IMHO legally nothing we can do about it anyway.  Use of
> an industry-standard API that is provided in multiple operating system
> is one of the clearest idnication of some program _not_ being a
> derivative work.

IMHO there is no industry-standard API for in-kernel use of sockets.
There is however one for user space.


Erik
(IANAL, etc)

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
