Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWAaSaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWAaSaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAaSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:30:16 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:27837 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751325AbWAaSaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:30:15 -0500
Date: Tue, 31 Jan 2006 13:30:13 -0500
To: Sander <sander@humilis.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131183013.GH18970@csclub.uwaterloo.ca>
References: <20060131115343.GA2580@favonius> <20060131163928.GE18972@csclub.uwaterloo.ca> <20060131171723.GA6178@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131171723.GA6178@favonius>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:17:23PM +0100, Sander wrote:
> According to page 7 of the 
> "Serial ATA Advanced Host Controller Interface Revision 1.1"
> (available at http://www.intel.com/technology/serialata/ahci.htm), AHCI
> supports up to 32 ports.

Hmm, that's a nice feature set.  Here is hoping everyone will consider
switching to that, and that no one screws it up and makes a mostly but
not quite compliant version.

> For example, Silicon Image 3124 also looks good on paper, but only
> supports up to 4 ports.
> 
> Yeah, I know, but because of their real 'hardware' raid, these cards are
> three times more expensive per port. And I just need JBOD.

Really?  How much does a 24 port areca card cost?  Is it 12 times the
cost of a two port promise card?

I haven't looked at the prices lately.

Len Sorensen
