Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbTCSOvV>; Wed, 19 Mar 2003 09:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263056AbTCSOvV>; Wed, 19 Mar 2003 09:51:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34948
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263055AbTCSOvV>; Wed, 19 Mar 2003 09:51:21 -0500
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED
	UNTILL NOW!)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Andrus <andrus@members.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030319145537.GB25934@h55p111.delphi.afb.lu.se>
References: <000001c2ee1f$02da6820$0100a8c0@andrus>
	 <1048087625.30750.34.camel@irongate.swansea.linux.org.uk>
	 <20030319145537.GB25934@h55p111.delphi.afb.lu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048090385.30750.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Mar 2003 16:13:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 14:55, Anders Gustafsson wrote:
> If access can't be shut down while compiling the new kernel 
> 
> echo /foo/bar/doesnotexist >/proc/sys/kernel/modprobe
> 
> would help, wouldn't it?

Against the default exploit circulating yes, in the general
case we don't believe so. Realistically we are a day or two
before a major war breaks out with huge amounts of bad
feeling involved. It is not the time to put off security
updates, especially if you have a potentially US or UK domain
name/address range

