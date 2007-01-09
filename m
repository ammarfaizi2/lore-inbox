Return-Path: <linux-kernel-owner+w=401wt.eu-S1751391AbXAINgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAINgE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 08:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXAINgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 08:36:04 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:3609 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751391AbXAINgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 08:36:03 -0500
Date: Tue, 9 Jan 2007 14:36:05 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "J.H." <warthog9@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070109143605.b33e508e.khali@linux-fr.org>
In-Reply-To: <1168327518.14963.38.camel@localhost.localdomain>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<20070108222045.644ec0be.khali@linux-fr.org>
	<1168291984.14963.25.camel@localhost.localdomain>
	<20070109080115.d7314b7a.khali@linux-fr.org>
	<1168327518.14963.38.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi J.H.,

On Mon, 08 Jan 2007 23:25:18 -0800, J.H. wrote:
> On Tue, 2007-01-09 at 08:01 +0100, Jean Delvare wrote:
> > > they cache just fine and it's not that big of a deal, and there are much
> > > longer poles in the tent right now.
> > 
> > The images are being regenerated every other minute or so, so I doubt
> > they can actually be cached.
> 
> Considering how many times the front page of kernel.org is viewed, yes
> they are cached and sitting in ram on the kernel.org boxes.

This is client-side caching (or lack thereof) I was thinking about, to
limit the number of requests received by the web server.

> Realistically - we are arguing over something that barely even registers
> as a blip within the entirety of the load on kernel.org, and we have
> bigger things to worry about than a restructuring of our front page when
> it won't greatly affect our loads.

You will know better, I was only suggesting things based on my limited
user experience. You have the actual numbers, you know where your
time and energy will be best used. And thank you for taking care of
it! :)

-- 
Jean Delvare
