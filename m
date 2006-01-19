Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161360AbWASUOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161360AbWASUOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbWASUOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:14:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22991 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161360AbWASUO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:14:28 -0500
Date: Thu, 19 Jan 2006 21:14:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Greg KH <greg@kroah.com>
cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
In-Reply-To: <20060119180947.GA25001@kroah.com>
Message-ID: <Pine.LNX.4.61.0601192014010.30994@scrub.home>
References: <20060119180947.GA25001@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Jan 2006, Greg KH wrote:

> Someone recently pointed out to me the following wording on some of the
> m68k files that reads:
> 
> |               Copyright (C) Motorola, Inc. 1990
> |                       All Rights Reserved
> |
> |       THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
> |       The copyright notice above does not evidence any
> |       actual or intended publication of such source code.

It has been published like this from Motorola and still is available at
http://www.freescale.com/files/32bit/software/app_software/code_examples/MC68040FPSP.html

> Any ideas of how they made it into our tree?  And any chance of
> correcting them to be the correct license or removing them?

The above is only a copyright notice, does this already constitute a 
license?
The actual license is in the README file.

bye, Roman
