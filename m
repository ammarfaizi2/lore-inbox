Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293486AbSBZDXV>; Mon, 25 Feb 2002 22:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSBZDXL>; Mon, 25 Feb 2002 22:23:11 -0500
Received: from [24.243.44.28] ([24.243.44.28]:32531 "EHLO explorer.dummynet")
	by vger.kernel.org with ESMTP id <S293486AbSBZDXF>;
	Mon, 25 Feb 2002 22:23:05 -0500
Date: Mon, 25 Feb 2002 21:22:43 -0600
From: Dan Hopper <dbhopper@austin.rr.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020226032243.GA1931@yoda.dummynet>
Mail-Followup-To: Dan Hopper <dbhopper@austin.rr.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet> <20020224064931.GD15060@kroah.com> <20020224173711.GA2355@yoda.dummynet> <20020224125055.A5232@sventech.com> <20020224184943.GA2492@yoda.dummynet> <20020224224107.D17788@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224224107.D17788@sventech.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt <johannes@erdfelt.com> remarked:
> Can you give this patch a whirl? It's relative to 2.4.18-rc2-gregkh-1

Sorry, didn't make any difference to the scanner.  

Now, in case it wasn't clear, the scanner does work, it just bumps
and grinds it's way down the page in the process with uhci, taking
considerably longer than with usb-uhci.  Very curious.

Thanks for the patch, though!

Dan
