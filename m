Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVAKIZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVAKIZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKIZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:25:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21178 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262539AbVAKIZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:25:48 -0500
Date: Tue, 11 Jan 2005 09:25:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Hikaru1@verizon.net
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050111082548.GE4551@suse.de>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll> <20050109123028.GA12753@roll> <20050109153212.GA28417@suse.de> <20050110091022.GA20178@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110091022.GA20178@roll>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10 2005, Hikaru1@verizon.net wrote:
> On Sun, Jan 09, 2005 at 04:32:16PM +0100, Jens Axboe wrote:
> > The change isn't safe, it was made for a reason since some drives
> > timeout if the alignment/length isn't correct. It probably is a little
> > pessimistic right now, can you see if this just works for you?
> 
> Owner of the system tested the patch, works perfectly on his system.
> 
> Thanks :)

Glad to hear it. I'll get some variant of it submitted for 2.6.11.

BTW, your email address doesn't work for me. I suggest you find
somewhere decent (verizon is not) to host your mail, if you wish to
continue discussing these matters.

-- 
Jens Axboe

