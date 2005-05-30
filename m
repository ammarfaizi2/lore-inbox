Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVE3Gqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVE3Gqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVE3Gqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:46:45 -0400
Received: from mournblade.cat.pdx.edu ([131.252.208.27]:21972 "EHLO
	mournblade.cat.pdx.edu") by vger.kernel.org with ESMTP
	id S261529AbVE3Gqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:46:43 -0400
Date: Sun, 29 May 2005 23:46:26 -0700 (PDT)
From: Judy Fischbach <jfisch@cs.pdx.edu>
To: Lukasz Stelmach <stlman@poczta.fm>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for MCS7780 USB-IrDA bridge chip
In-Reply-To: <4298510E.8030502@poczta.fm>
Message-ID: <Pine.GSO.4.58.0505292332530.7049@wezen.cs.pdx.edu>
References: <42943CB5.50400@poczta.fm> <20050525235846.GA28644@kroah.com>
 <4298510E.8030502@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2005, Lukasz Stelmach wrote:

> Greg KH napisał(a):
> > On Wed, May 25, 2005 at 10:52:05AM +0200, Lukasz Stelmach wrote:
> >
> >>You can download it from either:
> >>http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.1alpha.1.tar.bz2
> [...]
> > Nice, care to make up a patch as per the Documentation/SubmittingPatches
> > file and send it to the linux-usb-devel mailing list so people can
> > review it?
>
> I surely will make a patch but let me at least implement the speed
> changing. For without it the driver is just like a lawnmower instead of
>  beeing for example a scooter ;-)
>
Hello Lukasz and Greg,

I'm a graduate student at Portland State University in Prof Bart Massey's
OS Internals Class.  Many of us have been working on the driver for
this chip also and we just recently got SIR working at 9600. We are in
the currently in the process of testing. We would like to join forces,
share what we've done and help with efforts to add support for speed
changes, FIR and more testing.

Judy.
