Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWHQPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWHQPCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWHQPCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:02:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60678 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965112AbWHQPCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:02:40 -0400
Date: Thu, 17 Aug 2006 15:00:42 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend on Dell D420
Message-ID: <20060817150041.GB5950@ucw.cz>
References: <20060804162300.GA26148@uio.no> <200608050126.57060.rjw@sisk.pl> <20060805082321.GB27129@uio.no> <200608051108.01180.rjw@sisk.pl> <20060806115043.GA30671@uio.no> <20060806231013.GD4205@ucw.cz> <20060806231506.GA2784@uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806231506.GA2784@uio.no>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Interesting... I guess getting some dump where it hangs is not an
> > option? Does video work for you during resume?
> 
> Define "getting some dump". It doesn't react to anything, so I don't really
> think I can easily get anything out.

With some luck, you'll still get some messages before it hangs.. on
for example serial console.

-- 
Thanks for all the (sleeping) penguins.
