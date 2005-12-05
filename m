Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVLEQ1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVLEQ1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLEQ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:27:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41179 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932384AbVLEQ1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:27:38 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Rob Landley <rob@landley.net>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
In-Reply-To: <4394681B.20608@rtr.ca>
References: <20051203135608.GJ31395@stusta.de>
	 <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	 <200512042131.13015.rob@landley.net>  <4394681B.20608@rtr.ca>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 11:28:10 -0500
Message-Id: <1133800090.21641.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 11:17 -0500, Mark Lord wrote:
> >>>Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> >>>userspace interface broken during the series, does anyone have any more?
> 
> Ah.. another one, that I was just reminded of again
> by the umpteenth person posting that their wireless
> no longer is WPA capable after upgrading from 2.6.12.
> 
> Of course, the known solution for that issue is to
> upgrade to the recently "fixed" latest wpa_supplicant
> daemon in userspace, since the old one no longer works.
> 
> Things like this are all too regular an occurance.

The distro should have solved this problem by making sure that the
kernel upgrade depends on a new wpa_supplicant package.  Don't they
bother to test this stuff before they ship it?!?

Lee

