Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTDFQSK (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 12:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTDFQSK (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 12:18:10 -0400
Received: from smarthost3.mail.uk.easynet.net ([212.135.6.13]:4880 "EHLO
	smarthost3.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S263029AbTDFQSK (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 12:18:10 -0400
Date: Sun, 6 Apr 2003 17:23:01 +0100
To: linux-kernel@vger.kernel.org
Subject: Kernel support for 24-bit sound
Message-ID: <20030406162301.GA1364@pigeon.pigeonloft>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Pigeon <jah.pigeon@ukonline.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to add support for the 24-bit S/PDIF input mode of my
CMI8738 sound card to the cmpci.c driver of kernel 2.4.20.

I am hindered in this chiefly by lack of documentation.

If someone could supply me with the URL of some documentation
on kernel sound handling it would be much appreciated.

I am also somewhat worried that none of the valid arguments listed for
the SNDCTL_DSP_SETFMT ioctl seem to be for any kind of 24-bit format.
Is there in fact any kernel support for 24-bit sound in general?

Please CC me on replies; I'm on dialup and I can't cope with the
traffic on this list.

Many thanks

Pigeon
