Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTE0Xhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTE0Xht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:37:49 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:51669 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264449AbTE0Xht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:37:49 -0400
Date: Wed, 28 May 2003 00:52:42 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Mattia Dongili <dongili@supereva.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptopkernel-2.4.21-rc4-laptop1 released
Message-ID: <20030527235242.GA15145@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mattia Dongili <dongili@supereva.it>, linux-kernel@vger.kernel.org
References: <20030527211346.11bed9c1.hanno@gmx.de> <20030527232138.762f2ced.dongili@supereva.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527232138.762f2ced.dongili@supereva.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:21:38PM +0200, Mattia Dongili wrote:

 > > I have started a project to create a kernel-patch containing various
 > > laptop-specific things.
 > > Especially it contains acpi, software suspend, supermount and some
 > > hardware compatibility patches.
 > 
 > I expected to see also cpufreq patch. Is there a particular reason
 > it's not been added?  

The 2.4 branch of cpufreq is somewhat out of date.
Someone else may find time to backport all the recent changes
there (especially the powernow-k7 driver), but it won't be me.

		Dave


