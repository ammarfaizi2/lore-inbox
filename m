Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVAQTrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVAQTrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVAQTrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:47:31 -0500
Received: from dialin-160-45.tor.primus.ca ([216.254.160.45]:5760 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262846AbVAQTr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:47:29 -0500
Date: Mon, 17 Jan 2005 14:46:15 -0500
From: William Park <opengeometry@yahoo.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage on SMP?
Message-ID: <20050117194615.GA2028@node1.opengeometry.net>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Thomas Zehetbauer <thomasz@hostmaster.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1105982247.21895.26.camel@hostmaster.org> <200501171826.33496.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501171826.33496.rjw@sisk.pl>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 06:26:33PM +0100, Rafael J. Wysocki wrote:
> On Monday, 17 of January 2005 18:17, Thomas Zehetbauer wrote:
> > Hi,
> > 
> > can anyone confirm that writing to usb-storage devices is working on SMP
> > systems?
> 
> Generally, it is.  Recently, I've written some stuff to a USB pendrive (using
> 2.6.10-ac7 or -ac9).

Same here with Abit VP6 dual-P3 and 2.6.10.  It shows up as /dev/sda,
and I can do anything that I would do with normal harddisk.

But, I still can't boot from it. :/  I can now mount it as root
filesystem, but I can't load the kernel from USB key drive.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
