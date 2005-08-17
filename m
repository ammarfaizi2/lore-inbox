Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVHQAlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVHQAlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVHQAlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:41:39 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:21439
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S1750782AbVHQAlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:41:39 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73br3x1ke0.fsf@verdi.suse.de>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com.suse.lists.linux.kernel>
	 <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com.suse.lists.linux.kernel>
	 <1124161828.10755.87.camel@soltek.michaels-house.net.suse.lists.linux.kernel>
	 <20050816081622.GA22625@kroah.com.suse.lists.linux.kernel>
	 <1124199265.10755.310.camel@soltek.michaels-house.net.suse.lists.linux.kernel>
	 <20050816203706.GA27198@kroah.com.suse.lists.linux.kernel>
	 <4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com.suse.lists.linux.kernel>
	 <p73br3x1ke0.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 19:41:27 -0500
Message-Id: <1124239287.10755.322.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 02:23 +0200, Andi Kleen wrote:
> <Michael_E_Brown@Dell.com> writes:
> > 2) Dell OpenManage
> >     The main use of this driver by openmanage will be to read the System 
> > Event Log that BIOS keeps. Here are some other random relevant points:
> 
> Are there machine check events from the last boot in that event log? 

I don't know. Either Doug or Abhay may, though. If they don't I can ask
the BIOS guys.

--
Michael

