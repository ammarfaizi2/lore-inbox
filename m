Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUEAKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUEAKlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 06:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUEAKlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 06:41:08 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:43201 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262194AbUEAKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 06:41:03 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Bruce Guenter <bruceg@em.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
Date: Sat, 1 May 2004 12:48:33 +0200
User-Agent: KMail/1.5
References: <20040430014658.112a6181.akpm@osdl.org> <20040501061244.GA2438@em.ca>
In-Reply-To: <20040501061244.GA2438@em.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405011238.11420.rjwysocki@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 of May 2004 08:12, Bruce Guenter wrote:
> On Fri, Apr 30, 2004 at 01:46:58AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2
> >.6.6-rc3-mm1/
>
> I cannot get serial console to work in either 2.6.6-rc2-mm2 or
> 2.6.6-rc3-mm1.  It does work fine with 2.6.6-rc2, with an effectively
> identical configuration, and with the 2.6.5-gentoo kernel.  Serial
> console is enabled in the config (attached) and grub.

The serial console does not work in recent -mm kernels for me too (on an 
x86_64 system),

RJW


