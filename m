Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVDEKwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVDEKwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVDEKwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:52:42 -0400
Received: from main.gmane.org ([80.91.229.2]:58285 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261670AbVDEKwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:52:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@debian.org>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Tue, 05 Apr 2005 06:42:42 -0400
Message-ID: <pan.2005.04.05.10.42.36.735570@debian.org>
References: <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <20050405093258.GA18523@lst.de> <1112693819.6275.36.camel@laptopd505.fenrus.org> <20050405093902.GA18669@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: debian-kernel@lists.debian.org, debian-legal@lists.debian.org
Cc: debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Apr 2005 11:39:02 +0200, Christoph Hellwig wrote:

> On Tue, Apr 05, 2005 at 11:36:58AM +0200, Arjan van de Ven wrote:
>> One of the options is to even ship the firmware in the kernel tarbal but
>> from a separate directory with a clear license clarification text in it.
> 
> I think that's what we should do.  I currently don't have any firmware
> requiring devices, but I'd volunteer to keep such a tarball for now if
> no one else wants to do tiny amount of work.


FYI, I just created this, it might be useful for all this:
http://wiki.debian.net/?KernelFirmwareLicensing

I'm still adding driver information..

