Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292638AbSBZSRV>; Tue, 26 Feb 2002 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSBZSRS>; Tue, 26 Feb 2002 13:17:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42229
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292637AbSBZSPV>; Tue, 26 Feb 2002 13:15:21 -0500
Date: Tue, 26 Feb 2002 10:15:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Fridtjof Busse <fridtjof.busse@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18-ac1] Unable to mount root fs
Message-ID: <20020226181559.GQ4393@matchmail.com>
Mail-Followup-To: Fridtjof Busse <fridtjof.busse@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202261722.13431@fbunet.de> <200202261834.39908@fbunet.de> <20020226174455.GO4393@matchmail.com> <200202261907.20103@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202261907.20103@fbunet.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 07:11:21PM +0100, Fridtjof Busse wrote:
> On Tuesday, 26. February 2002 18:44, Mike Fedyk wrote:
> > Did you run 'make oldconfig' after using your old .config file?
> 
> Yes
> 
> > Post your .config.  That is probably the problem.
> 
> Attached
> 

> # CONFIG_BLK_DEV_PDC202XX is not set

Here you go.  Promise IDE is not compiled into the kernel.

Mike
