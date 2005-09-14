Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVINMjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVINMjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVINMjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:39:35 -0400
Received: from 148.225.77.83.cust.bluewin.ch ([83.77.225.148]:36733 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S965142AbVINMje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:39:34 -0400
Date: Wed, 14 Sep 2005 14:39:23 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Search in make menuconfig doesn't work properly
Message-ID: <20050914123923.GA16649@kestrel>
References: <20050914065010.GA8430@kestrel.twibright.com> <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509140524490.4846@lancer.cnet.absolutedigital.net>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 05:27:49AM -0400, Cal Peake wrote:
> On Wed, 14 Sep 2005, Karel Kulhavy wrote:
> 
> > I have 2.6.13 and if I press '/' in make menuconfig (Search
> > Configuration Parameter, Enter Keyword) and enther "emulation", it
> > doesn't find
> > CONFIG_BLK_DEV_IDESCSI -  SCSI emulation support.
> 
> AFAIK it only matches against the CONFIG_ symbols. If you want it to do 
> more cook up a patch ;)

I suggest "Enter Keyword" to be changed to "Enter Keyword to search
in CONFIG_... symbols".

CL<
