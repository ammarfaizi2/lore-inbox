Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTDGNlZ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTDGNlZ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:41:25 -0400
Received: from smarthost0.mail.uk.easynet.net ([212.135.6.10]:3593 "EHLO
	smarthost0.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S263434AbTDGNlY (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:41:24 -0400
Date: Mon, 7 Apr 2003 14:09:30 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel support for 24-bit sound
Message-ID: <20030407130930.GB712@pigeon.pigeonloft>
References: <20030406162301.GA1364@pigeon.pigeonloft> <1049646540.1349.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049646540.1349.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Pigeon <jah.pigeon@ukonline.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 05:29:01PM +0100, Alan Cox wrote:
> On Sul, 2003-04-06 at 17:23, Pigeon wrote:
> > I am trying to add support for the 24-bit S/PDIF input mode of my
> > CMI8738 sound card to the cmpci.c driver of kernel 2.4.20.
> 
> 2.4.21pre -ac and I think now base trees have 24bit support in the
> core code included and support for 24bit USB devices added. OSS 
> doesn't really think happily in 24bit mode and the apps don't know
> about it either. The ALSA layer in 2.5.x is a rather nicer replacement
> without a lot of the limitations

Many thanks, that is extremely useful, have downloaded
2.4.21-pre5-ac3. Nice one!

Pigeon
