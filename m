Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWHXRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWHXRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWHXRY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:24:28 -0400
Received: from mga05.intel.com ([192.55.52.89]:56371 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030412AbWHXRY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:24:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,165,1154934000"; 
   d="scan'208"; a="120707032:sNHT16645461"
Date: Thu, 24 Aug 2006 10:23:48 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060824172347.GA24434@goober>
References: <20050427124911.6212670f@griffin.suse.cz> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober> <200608231859.32304.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608231859.32304.prakash@punnoor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 06:59:32PM +0200, Prakash Punnoor wrote:
> Am Samstag 19 August 2006 02:16 schrieb Valerie Henson:
> > Hey folks,
> >
> > Added to my to-do list.  Let me know if you figure out anything else.
> 
> As it comes back to my mind: Last time I tested dhcpcd doesn't work. dhclient 
> does, but takes a lot of time. (The dhcp server is debian based.) Other cards 
> don't have a problem. They get their ip assigned fast and with either dhcpocd 
> or dhclient.

Tcpdump on client and server, please?

-VAL
