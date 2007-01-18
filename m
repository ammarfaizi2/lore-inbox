Return-Path: <linux-kernel-owner+w=401wt.eu-S1750861AbXARHsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXARHsx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbXARHsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:48:53 -0500
Received: from main.gmane.org ([80.91.229.2]:38139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbXARHsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:48:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicolas Bareil <nico@chdir.org>
Subject: Re: Linux 2.6.19.2 : Oops
Date: Thu, 18 Jan 2007 08:48:30 +0100
Message-ID: <87sle8wzap.fsf@boz.loft.chdir.org>
References: <873b6a6ji0.fsf@boz.loft.chdir.org>
	<20070117233545.GA12717@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88.191.14.36
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Cancel-Lock: sha1:ef1a+z5kf1ROyX7RwE8mmbxye4k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jan 2007, Greg KH wrote:
> > Since 2.6.19, I get the following Oops once a day, always with the same
> > process, newspipe[1] which use a lot of CPU, threads and I/O.
> > ...
> Can you reproduce it without the grsec patch applied?

I'm compiling a new kernel and will try it soon!

-- 
Nicolas Bareil                                  http://chdir.org/~nico/
OpenPGP=0xAE4F7057 Fingerprint=34DB22091049FB2F33E6B71580F314DAAE4F7057

