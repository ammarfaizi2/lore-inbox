Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbTFMUvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbTFMUvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:51:15 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:64013 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265528AbTFMUvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:51:14 -0400
Date: Fri, 13 Jun 2003 23:05:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030613230500.A3253@pclin040.win.tue.nl>
References: <20030612111437.GE28900@mea-ext.zmailer.org> <20030612151704.A2588@pclin040.win.tue.nl> <20030612145814.GB14795@suse.de> <20030612150909.GI28900@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030612150909.GI28900@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Thu, Jun 12, 2003 at 06:09:09PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 06:09:09PM +0300, Matti Aarnio wrote:
> On Thu, Jun 12, 2003 at 03:58:14PM +0100, Dave Jones wrote:

[all clipped - later]

I was reminded of the following quote:

  "The thing that has always disturbed me about O_DIRECT is that the whole
  interface is just stupid, and was probably designed by a deranged monkey
  on some serious mind-controlling substances."

I'll add that to the BUGS section.

