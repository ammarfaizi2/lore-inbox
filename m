Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTAGTYx>; Tue, 7 Jan 2003 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbTAGTYx>; Tue, 7 Jan 2003 14:24:53 -0500
Received: from magic.adaptec.com ([208.236.45.80]:5588 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S267478AbTAGTYv>;
	Tue, 7 Jan 2003 14:24:51 -0500
Date: Tue, 07 Jan 2003 12:32:48 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Michael Madore <mmadore@aslab.com>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <449970000.1041967967@aslan.btc.adaptec.com>
In-Reply-To: <3E1B0500.2030500@aslab.com>
References: <3E1B0500.2030500@aslab.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am receiving the following messages in my system log when stress testing
> with Cerberus (http://sourceforge.net/projects/va-ctcs).  This is with an
> onboard Adaptec 7902 Ultra 320 SCSI adapter.  The messages are
> reproducible on two different systems.  This is with the 1.1.0 aic79xx
> driver, on both the stock Redhat kernel, and with a kernel compiled from
> the 2.4.19 sources. The system does not seem to be harmed by the
> messages, but I would like to know if they point to a problem or not.
> Interestingly, if I put and Adaptec 29320 PCI card into the same machine,
> and use the same driver, the error is not reproducible.

I would need to see *all* of the messages in order to tell you what they
mean.  The log is truncated.  Perhaps you can send me the full output
off list since it may be large?

--
Justin

