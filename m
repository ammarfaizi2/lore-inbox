Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbRG3UhR>; Mon, 30 Jul 2001 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRG3UhH>; Mon, 30 Jul 2001 16:37:07 -0400
Received: from mx1.afara.com ([63.113.218.20]:38341 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S267806AbRG3Ugv>;
	Mon, 30 Jul 2001 16:36:51 -0400
Subject: Re: serial console and kernel 2.4
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Chris Wedgwood <cw@f00f.org>
Cc: christophe@weta.f00f.org, barb@weta.f00f.org,
        Stuart MacDonald <stuartm@connecttech.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010731045527.A5863@weta.f00f.org>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain>
	<20010730173702.C19605@pc8.lineo.fr>
	<035001c1190f$c6b46700$294b82ce@connecttech.com>
	<20010730182124.C20366@pc8.lineo.fr>  <20010731045527.A5863@weta.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11.99 (Preview Release)
Date: 30 Jul 2001 13:36:32 -0700
Message-Id: <996525392.3352.4.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 30 Jul 2001 20:33:35.0172 (UTC) FILETIME=[E7D83840:01C11936]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 31 Jul 2001 04:55:27 +1200, Chris Wedgwood wrote:
> On Mon, Jul 30, 2001 at 06:21:24PM +0200, christophe barb? wrote:
> 
>     Do you remember a related thread ? with a correct solution ?
> 
> Upgrade init ?

to what?  and which version is broken?

I am seeing a problem on an x86 machine <-> sparc64 machine (E3500) both
running linux.  the sparc box has the latest debian woody and the x86 is
running the latest redhat 7.1.  x86 is running 2.4.3+xfs and sparc64 is
running 2.4.7+vger.samba.org.  I can type on the sparc and see output on
the x86, but not vice versa.

-tduffy

