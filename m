Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUHEKrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUHEKrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267627AbUHEKrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:47:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54688 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267626AbUHEKrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:47:48 -0400
Date: Thu, 5 Aug 2004 06:47:00 -0400
From: Alan Cox <alan@redhat.com>
To: Elmar Hinz <elmar.hinz@vcd-berlin.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
Message-ID: <20040805104700.GB11584@devserv.devel.redhat.com>
References: <2obsK-5Ni-13@gated-at.bofh.it> <4110ECBF.9070000@vcd-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4110ECBF.9070000@vcd-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 04:03:43PM +0200, Elmar Hinz wrote:
> When I set in the bios RAID 1 there comes an message similar
> INVALID GEOMETRY: 0 PHYSICAL HEADS?
> and booting stops.

At which point

> but booting continous and I can use the disks.
> hdparm => 15.70 MB/sec

A bit slow.. thanks

