Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUGKGOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUGKGOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 02:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUGKGOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 02:14:03 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:8684 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S266252AbUGKGOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 02:14:01 -0400
Date: Sun, 11 Jul 2004 08:13:51 +0200
From: Antonin Kral <A.Kral@sh.cvut.cz>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: AIC79xx problem [was; Re: Fatal problem, possibly related to AIC79xx]
Message-ID: <20040711061351.GA4190@sh.cvut.cz>
References: <A6974D8E5F98D511BB910002A50A6647615FFBBF@hdsmsx403.hd.intel.com> <1089513010.32034.36.camel@dhcppc2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089513010.32034.36.camel@dhcppc2>
X-URL: http://www.bobek.cz
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Len Brown <len.brown@intel.com> [2004-07-11 04:30] wrote:
> On Sat, 2004-07-10 at 11:21, Antonin Kral wrote:
> If you'd like to have just 1 processor instead of two, then
> enter the BIOS SETUP and disable HyperThreading (HT),
> or boot the SMP kernel with maxcpus=1.

Yes, you are right and I realizes this myself as well. Sorry for making
waves. But at that time, I was able to find only this.

> I have no insight into your potential AIC79XX problem...

I've checked that the problem is closely releated to AIC79xx, because it
raises when I use SCSI. I've got some old IDE disk and with it work
everything perfectly.

    Antonin
