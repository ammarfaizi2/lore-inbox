Return-Path: <linux-kernel-owner+w=401wt.eu-S1750963AbXAFAqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbXAFAqV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbXAFAqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:46:21 -0500
Received: from mx1.suse.de ([195.135.220.2]:57441 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbXAFAqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:46:21 -0500
Date: Fri, 5 Jan 2007 16:45:52 -0800
From: Greg KH <greg@kroah.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PL2303 module
Message-ID: <20070106004552.GA6374@kroah.com>
References: <200612272248.06893.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612272248.06893.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 10:48:06PM -0500, Gene Heskett wrote:
> Greetings;
> 
> Rather offtopic, but:
> 
> Is there available anyplace, a document that describes how to configure 
> the PL2303 USB<->serial adaptor to match up with all the hardware and 
> flow control variations inherent in the basic rs-232 spec?

It should work like any other serial port on Linux, so try the serial
port programming HOWTO.

good luck,

greg k-h
