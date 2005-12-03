Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLCRNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLCRNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVLCRNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:13:41 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65185 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932069AbVLCRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:13:40 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: David Ranson <david@unsolicited.net>
Cc: linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
In-Reply-To: <4391CEC7.30905@unsolicited.net>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <4391CEC7.30905@unsolicited.net>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 12:13:32 -0500
Message-Id: <1133630012.6724.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 16:58 +0000, David Ranson wrote:
> Matthias Andree wrote:
> 
> >>>the model needs finetuning. Right now the biggest pain is the userland
> >>>ABI changes that need new packages; sometimes (often) for no real hard
> >>>reason. Maybe we should just stop doing those bits, they're not in any
> >>>fundamental way blocking general progress (sure there's some code bloat
> >>>due to it, but I guess we'll just have to live with that)
> >>>
> >>>
> Well as a mildly technical 'user' who's been tracking the 2.6 series I
> can't recall having to update _any_ userland packages due to kernel
> changes. An example of this would be helpful.

udev ;)

http://seclists.org/lists/linux-kernel/2005/Dec/0180.html

-- Steve


