Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTKLHHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 02:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTKLHHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 02:07:17 -0500
Received: from continuum.cm.nu ([216.113.193.225]:16771 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S261840AbTKLHHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 02:07:15 -0500
Date: Tue, 11 Nov 2003 23:07:10 -0800
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031112070710.GA6172@cm.nu>
References: <20031109210527.GA1936@cm.nu>
	<Pine.LNX.4.44.0311100846070.16790-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311100846070.16790-100000@logos.cnet>
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
X-Delivery-Agent: TMDA/0.86 (Venetian Way)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:46:38AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Sun, 9 Nov 2003, Shane Wegner wrote:
> 
> > Hi,
> > 
> > I posted some weeks ago regarding a crash I was
> > experiencing with 2.4.23-pre4.  I am just writing to
> > confirm that 2.4.23-pre9 is still unable to run relyably on
> > this machine.  In my earlier post, I thought acpi might be
> > the culprit as I had it enabled due to a bios bug.  Intel
> > since fixed that so I was able to boot 2.4.23-pre9 with
> > acpi totally disabled in make config.
> 
> Shane,
> 
> Tracking down which -pre this started to happen would help a lot.

Ok, it starts happening in pre4.  I am running pre3 now and
all is stable.  The kernels I am using for testing are
compiled without acpi but that doesn't make a difference.

Shane
