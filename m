Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbTLVXwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTLVXwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:52:07 -0500
Received: from codepoet.org ([166.70.99.138]:39045 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264574AbTLVXwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:52:04 -0500
Date: Mon, 22 Dec 2003 16:52:02 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Tom Felker <tcfelker@mtco.com>
Cc: Stan Bubrouski <stan@ccs.neu.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
Message-ID: <20031222235202.GA2439@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Tom Felker <tcfelker@mtco.com>, Stan Bubrouski <stan@ccs.neu.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312221519.04677.tcfelker@mtco.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 22, 2003 at 03:19:04PM -0600, Tom Felker wrote:
> Where did the 0.97 to present version come from?

For errno.h, according to this:
    http://www.geocrawler.com/archives/3/360/1997/11/0/1999771/
I got Linus to add ENOMEDIUM and EMEDIUMTYPE into the kernel for
2.0.32, as part of my work on (what was to become) the Uniform
cdrom driver, based on original work from David van Leeuwen.
    http://www.ussg.iu.edu/hypermail/linux/kernel/9704.0/0105.html
I then helped push these defines into glibc and libc5.

So at least those two defines are clearly not SCO derived...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
